package com.univ.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.univ.daoimpl.DaoImpl;
import com.univ.daoimpl.TransactionDaoImpl;
import com.univ.pojo.Cart;
import com.univ.pojo.StockInfo;
import com.univ.pojo.Transactions;
import com.univ.pojo.UserInfo;
import com.univ.repo.CartRepo;
import com.univ.repo.StockInfoRepo;
import com.univ.repo.TransactionsRepo;
import com.univ.repo.UserInfoRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class addUpdateDeleteController {
	@Autowired
    private MailSender otpMailService;

    @Autowired
    private DaoImpl di;
    
    @Autowired
    private TransactionDaoImpl tdi;
    
    @Autowired
    private StockInfoRepo strepo;
    
    @Autowired
    private UserInfoRepo repo;
    
    @Autowired
    private TransactionsRepo trepo;
    
    @Autowired
    private CartRepo crepo;
    
    @PostMapping("/addStocks")
    public ModelAndView addStocks(@RequestParam("cname") String cname,
    		@RequestParam("rate") Double rate,
            @RequestParam("av") String ava,
            @RequestParam("quant") int quantity,
            @RequestParam("dp") MultipartFile file, Model m) throws Exception {

        StockInfo u = new StockInfo();
        u.setSname(cname);
        u.setRate(rate);
        u.setAvailability(ava);
        u.setAvailableStocks(quantity);
        u.setDp(file.getOriginalFilename());

        ModelAndView mv;

        // ✅ fixed file save path
        String serverurl = "C:\\Users\\Aayush\\eclipse-workspace\\JeeFinalProj\\Boot\\Boot_FinalProj-1\\src\\main\\resources\\static\\images\\";
        File serverfile = new File(serverurl + file.getOriginalFilename());
        file.transferTo(serverfile);

        if (strepo.save(u) != null) {
            mv = new ModelAndView("addStocks", "msg", "Stock Registered Successfully");
        } else {
            mv = new ModelAndView("addStocks", "msg", "Stock Already Exists / Could Not be Added");
        }

        return mv;
    }
    
    @PostMapping("/updateStock")
    public ModelAndView updateStock(
            @RequestParam("sname") String sname,
            @RequestParam("rate") Double rate,
            @RequestParam("availability") String ava,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value ="quantity", required=false) int quantity,
            @RequestParam(value ="squantity", required=false) Integer squantity,
            @RequestParam(value ="liquid", required=false) Double liquid,
            @RequestParam("sid") int sid,
            @RequestParam("btn") String btn, HttpServletRequest request,Model m
    ) throws Exception {

        ModelAndView mv = new ModelAndView("stockDetails");

        StockInfo existingStock = strepo.findBySid(sid);
        
        HttpSession session = request.getSession();

        // always send stock back to JSP
        mv.addObject("stock", existingStock);

        // ----------------------------------------------
        // CASE 1: ADMIN UPDATES STOCK
        // ----------------------------------------------
        if ("update".equalsIgnoreCase(btn)) {

            double oldPrice = existingStock.getRate();

            existingStock.setSname(sname);
            existingStock.setRate(rate);
            existingStock.setAvailability(ava);
            existingStock.setAvailableStocks(quantity);
            existingStock.setLiquid(liquid);

            if (strepo.save(existingStock) != null) {

                List<Transactions> holders =
                        trepo.findBySnameAndWd(existingStock.getSname(),"buy");

                for (Transactions buy : holders) {

                    double pl = (rate - buy.getPps()) * buy.getQuantity();

                    Transactions lastTxn =
                            trepo.findTopByUsernameOrderByTidDesc(buy.getUsername());

                    Transactions t = new Transactions();
                    t.setUsername(buy.getUsername());
                    t.setSname(existingStock.getSname());
                    t.setQuantity(buy.getQuantity());
                    t.setPps(rate);
                    t.setTotal(pl);
                    t.setCurrTotal(lastTxn.getCurrTotal() + pl);
                    t.setWd(pl >= 0 ? "profit" : "loss");
                    t.setDateTime(LocalDateTime.now());

                    trepo.save(t);
                }

                mv.addObject("msg", "Stock updated & P/L calculated");

            } else {
                mv.addObject("msg", "Stock update failed");
            }

            return mv;
        }

        // CASE 2: USER ADDS TO CART
        if ("cart".equalsIgnoreCase(btn)) {

            int qty = squantity;  // user-entered quantity

            Cart c = new Cart();
            c.setSid(sid);
            c.setSname(existingStock.getSname());
            c.setDp(existingStock.getDp());     // use stock image, NOT uploaded file
            c.setRate(existingStock.getRate());
            c.setCurrentRate(existingStock.getRate());
            c.setQuantity(qty);
            c.setTotal(qty * existingStock.getRate());
            c.setUsername((String)session.getAttribute("username"));
            
            /*ModelAndView mv1 = new ModelAndView("cart");
			 * if (tdi.addToCart(c)) { mv1.addObject("msg", "Added To Cart"); } else {
			 * mv1.addObject("msg", "Some error occurred"); }
			 * 
			 * return mv1;
			 */
            
            if (crepo.save(c) != null) {
                return new ModelAndView("redirect:/cart");
            }

            ModelAndView mv2 = new ModelAndView("stockDetails");
            mv2.addObject("msg", "Failed to add to cart");
            return mv2;
            
        }
        
        //case:3
        if("sell".equalsIgnoreCase(btn))
    	{	List<Transactions> t1 = (List<Transactions>) trepo.findByUsername((String)session
    			.getAttribute("username"));
    		Cart ct = (Cart) session.getAttribute("cartstatus");
    		Transactions t2 = t1.get(t1.size()-1);
    		existingStock.setAvailableStocks(existingStock.getAvailableStocks() +squantity); 
    		existingStock.setLiquid(existingStock.getLiquid()-(existingStock.getRate()*squantity));
    		LocalDateTime ld = LocalDateTime.now();
    		Transactions tt = new Transactions();
    		tt.setDateTime(ld);
    		tt.setSname(existingStock.getSname());
    		//tt.setPps(existingStock.getRate());
    		tt.setQuantity(squantity);
    		tt.setUsername((String)session.getAttribute("username"));
    		tt.setTotal(existingStock.getRate()*squantity);
    		tt.setCurrTotal(t2.getCurrTotal()+(existingStock.getRate()*squantity));
    		tt.setWd("sell");
    		
    		int bax = ct.getQuantity()-squantity;
    		
    		if(bax==0) 
    		{
    			crepo.delete(ct);
    		}else 
    		{	
    			ct.setQuantity(ct.getQuantity()-squantity);
    			crepo.save(ct);
    		}
    		
    		if(strepo.save(existingStock) != null  && trepo.save(tt) != null) {
    			otpMailService.sendSellMail((String)session.getAttribute("username"),
    					existingStock);
    			return mv.addObject("msg","Sold Success");
    		}
    		else
    			return mv.addObject("msg","Could Not Sell");
    	}
        
        // fallback
        mv.addObject("msg", "Invalid operation");
        return mv;
    }


    
    @PostMapping("/updateUser")
    public ModelAndView updateUser(@RequestParam("uid") int uid,
                                   @RequestParam("fname") String fname,
                                   @RequestParam("lname") String lname,
                                   @RequestParam("email") String email,
                                   @RequestParam("contact") String contact,
                                   @RequestParam("address") String address,
                                   @RequestParam("role") String type,
                                   @RequestParam("status") String status) throws Exception {

        ModelAndView mv;

        // Fetch existing user
        UserInfo existingUser = di.getUserById(uid);
        
        if(existingUser.getStatus().equalsIgnoreCase(status) == false) {
        	otpMailService.sendConfirmationMail(email);
        }

        if (existingUser != null) {
            existingUser.setFname(fname);
            existingUser.setLastname(lname);
            existingUser.setEmail(email);
            existingUser.setContact(contact);
            existingUser.setAddress(address);
            existingUser.setType(type);
            existingUser.setStatus(status);
            
            
            
			/*
			 * String serverurl =
			 * "C:\\Users\\Aayush\\eclipse-workspace\\JeeFinalProj\\FinalProject\\src\\main\\webapp\\resources\\images\\";
			 * File serverfile = new File(serverurl + file.getOriginalFilename());
			 * 
			 * if(!(existingUser.getImage().equals(file.getOriginalFilename()))) {
			 * existingUser.setImage(file.getOriginalFilename());
			 * file.transferTo(serverfile); }
			 */
            
            if (type != null) {
                existingUser.setType(type);
            }

            if (repo.save(existingUser) != null) {
                mv = new ModelAndView("userDetails", "msg", "User Updated Successfully");
            } else {
                mv = new ModelAndView("userDetails", "msg", "User Could Not be Updated");
            }

            mv.addObject("user", existingUser);
        } else {
            mv = new ModelAndView("userDetails", "msg", "User Not Found");
        }

        return mv;
    }
    
    
    @PostMapping("/blockUser")
    public ModelAndView blockUser(@RequestParam("uid") int uid) {
        UserInfo user = repo.findByUid(uid);
        ModelAndView mv;

        if (user != null) {
            user.setType(user.getType()); // keep existing role
            user.setStatus("Suspended"); // assuming your entity has status column
            repo.save(user);
            mv = new ModelAndView("userDetails", "msg", "🚫 User Blocked Successfully");
            mv.addObject("user", user);
        } else {
            mv = new ModelAndView("userDetails", "msg", "⚠️ User Not Found");
        }

        return mv;
    }

    @PostMapping("/deleteUser")
    public ModelAndView deleteUser(@RequestParam("uid") int uid) {
        UserInfo user = repo.findByUid(uid);
        ModelAndView mv;

        if (user != null) {
            if (repo.findById(uid) != null) { 
            	repo.delete(user);
                mv = new ModelAndView("manageUsers", "msg", "🗑 User Deleted Successfully");
            } else {
                mv = new ModelAndView("userDetails", "msg", "❌ Failed to Delete User");
                mv.addObject("user", user);
            }
        } else {
            mv = new ModelAndView("userDetails", "msg", "⚠️ User Not Found");
        }

        return mv;
    }
    
    
    @PostMapping("/deleteStock")
    public ModelAndView deleteStock(@RequestParam("uid") int uid) {
        StockInfo stock = di.getStockById(uid);
        ModelAndView mv;

        if (stock != null) {
            if (strepo.findById(stock.getSid()) !=null) {
            	strepo.delete(stock);
                mv = new ModelAndView("manageUsers", "msg", "🗑 stock Deleted Successfully");
            } else {
                mv = new ModelAndView("userDetails", "msg", "❌ Failed to Delete stock");
                mv.addObject("user", stock);
            }
        } else {
            mv = new ModelAndView("userDetails", "msg", "⚠️ stock Not Found");
        }

        return mv;
    }
    
    /** ✅ Manage Users + Stocks Page **/
    @GetMapping("/manageUsers")
    public String manageUsers(
            @RequestParam(value="searchQuery", required=false) String searchQuery,
            @RequestParam(value="stockQuery", required=false) String stockQuery,
            Model m) {

        System.out.println("User Search: " + searchQuery);
        System.out.println("Stock Search: " + stockQuery);

        // ----- User Table -----
        List<UserInfo> users= new ArrayList<UserInfo>();
        if (searchQuery != null && !searchQuery.isEmpty()) {
            try {
                // If numeric, search by ID
                int id = Integer.parseInt(searchQuery);
                UserInfo u2 = repo.findByUid(id);
                if(u2 != null) {
                users = List.of(u2);
                }else {
                	m.addAttribute("Not Found!","msg");
                }
            } catch (NumberFormatException e) {
                // Otherwise, search by name/email
                users =repo.findByFname(searchQuery);
            }
        } else {
            users = repo.findAll();
        }

        // ----- Stock Table -----
        List<StockInfo> stocks = new ArrayList<StockInfo>();
        if (stockQuery != null && !stockQuery.isEmpty()) {
            try {
                int sid = Integer.parseInt(stockQuery);
                StockInfo sd = strepo.findBySid(sid);
                if(sd != null) {
                stocks = List.of(sd);
                }else {
                	m.addAttribute("Not Found!","msg");
                }
            } catch (NumberFormatException e) {
                stocks = strepo.findBySname(stockQuery);
            }
        } else {
            stocks = strepo.findAll();
        }

        m.addAttribute("users", users);
        m.addAttribute("stocks", stocks);
        return "manageUsers";
    }

    
    /** ✅ Manage Users + Stocks Page **/
    @GetMapping("/userspending")
    public String manageUsersatpending(Model m) 
    {
        List<UserInfo> users;
          users = repo.findByStatus("Pending");
        m.addAttribute("users1", users);
        return "userspending";
    }
    
    @GetMapping("/usersuspended")
    public String manageUsersuspended(Model m) 
    {
        List<UserInfo> users;
          users = repo.findByStatus("Suspended");
        m.addAttribute("users1", users);
        return "usersuspended";
    }

}
