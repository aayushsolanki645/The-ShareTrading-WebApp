package com.univ.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
public class LogInController {
	
	@Autowired
	private MailSender ms;
	
	@Autowired
    private UserInfoRepo repo;
	
	@Autowired
    private StockInfoRepo strepo;
	
	@Autowired
    private TransactionsRepo trepo;
	
	@Autowired
    private CartRepo crepo;
	
	/*
	 * @Autowired private DaoImpl di;
	 * 
	 * @Autowired private TransactionDaoImpl tdi;
	 */

    @RequestMapping("/")
    public String indexPage(Model m) {
        m.addAttribute("userObj", new UserInfo());
        return "index";
    }

    @GetMapping("/index")
    public String showLogin(Model model) {
        model.addAttribute("userObj", new UserInfo());
        return "index";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }
    
    @GetMapping("/learnTrading")
    public String ltrading() {
        return "learnTrading";
    }

    @GetMapping("/about")
    public String about() {
        return "about";
    }
    
    @GetMapping("/addStocks")
    public String stockaddpage() {
        return "addStocks";
    }

    @GetMapping("/home")
    public String showHome(Model m) {
    	List<Transactions> stlst = new ArrayList<Transactions>();
    	List<Transactions> tlst = trepo.findAll();
    	System.out.println("tlst"+tlst.get(1));
    	int stc = (int) strepo.count();
    	m.addAttribute("stc",stc);
    	int uc = (int) repo.count();
    	m.addAttribute("uc",uc);
    	List<UserInfo> uspd = repo.findByStatus("Pending");
    	System.out.println(uspd.size()+"lll");
    	int us = uspd!=null? uspd.size():0;
    	m.addAttribute("uspd",us);
    	List<UserInfo> ussd1 = repo.findByStatus("Suspended");
    	int ussd = ussd1!=null? uspd.size():0;
    	m.addAttribute("ussd",ussd);
    	System.out.println(uc+"helll"+stc);
    	
    	for (Transactions transactions : tlst) {
			if("buy".equals(transactions.getWd()) || "sell".equals(transactions.getWd())) {
				stlst.add(transactions);
			}
		}
    	System.out.println("stlst"+stlst.get(1));
    	m.addAttribute("stlst",stlst);
        return "home";
    }
    
    @GetMapping("/dash")
    public String showDash() {
        return "dash";
    }
    
    @GetMapping("/marcketWatch")
    public String marcketWatch(Model m) {
    	List<StockInfo> lst = strepo.findAll();
    	m.addAttribute("lst", lst);
    	System.out.println(lst.isEmpty());
        return "marcketWatch";
    }
    
    @GetMapping("/userHome")
    public String userHome(Model m, HttpServletRequest request) {
    	
    	 HttpSession session = request.getSession(false);
    	    if (session == null || session.getAttribute("username") == null) {
    	        return "redirect:/index"; // 🔥 BLOCK back button access
    	    }
    	
        String username = (String) session.getAttribute("username");
        
        List<Cart> lst = crepo.findByUsernameAndStatus(username,"Done");
		 m.addAttribute("lst", lst); List<Transactions> t = (List<Transactions>)
		 trepo.findByUsername(username);
		 if(t.isEmpty()==false)
		 session.setAttribute("total1",t.get(t.size()-1).getCurrTotal()); else
		 session.setAttribute("total1",0.0);

        for (Cart c : lst) {
            StockInfo stock = strepo.findBySid(c.getSid());
            c.setCurrentRate(stock.getRate());
            System.out.println(stock.getRate()+"pfpfp");
            
        }
        m.addAttribute("lst", lst);

        // Overall Unrealized P/L
        double overallPL = 0;
        for (Cart c : lst) {
            overallPL +=
                (c.getCurrentRate() - c.getRate()) * c.getQuantity();
        }
        session.setAttribute("total", overallPL);

        // Today's P/L (UNREALIZED – temporary)
        double todayPL = overallPL;
        m.addAttribute("todayPL", todayPL);

        return "userHome";
    }

    
    @GetMapping("/userDetails")
    public String showUserdetail(@RequestParam("id") int id, Model model) {
        UserInfo user = repo.findByUid(id); 
        model.addAttribute("user", user);
        return "userDetails";
    }

    @GetMapping("/stockDetails")
    public String showStockDetails(@RequestParam("id") int sid, Model model) {
        StockInfo stock = strepo.findBySid(sid);
        model.addAttribute("stock", stock);
        return "stockDetails"; // JSP name
    }
    
    @GetMapping("/cart")
    public String showCartDetails(Model model,HttpServletRequest request) {
    	HttpSession session = request.getSession();
        List<Cart> cart = crepo.findByUsernameAndStatus((String)session.getAttribute("username"),"Pending");
        model.addAttribute("cart", cart);
        return "cart"; // JSP name
    }


    /** ✅ Login Validation **/
    @PostMapping("/checkUser")
    public String checkUser(@RequestParam("username") String user,
    		@RequestParam("password") String pass, Model m, HttpServletRequest request) {
        UserInfo u = new UserInfo();
        u.setEmail(user);
        u.setPassword(pass);

        Optional<UserInfo> user12 = repo.findUserInfoByEmailAndPassword(user, pass);
        
        if (user12.isEmpty() == false) {
        	UserInfo user1 =  user12.get();
        	HttpSession session = request.getSession(false);
			if(session!=null)
			{
				session.invalidate();
			}
			session = request.getSession(true);
			m.addAttribute("msg","Welcome To Universal Informatics");
			session.setAttribute("username",user1.getEmail());
			session.setAttribute("dp",user1.getImage());
			session.setAttribute("userid", user1.getUid());
			session.setAttribute("usertype", user1.getType());
        		
        		if("Pending".equalsIgnoreCase(user1.getStatus()) || "Suspended".equalsIgnoreCase(user1.getStatus()))
        			return "pending";
        		else
        		{
        		if("Trader".equalsIgnoreCase(user1.getType()))
				{ 
					 List<Cart> lst2 = crepo.findByUsernameAndStatus((String)user1.getEmail(),"Done");
					 m.addAttribute("lst", lst2); List<Transactions> t = (List<Transactions>)
					 trepo.findByUsername((String)user1.getEmail());
					 if(t.isEmpty()==false)
					 session.setAttribute("total1",t.get(t.size()-1).getCurrTotal()); else
					 session.setAttribute("total1",0.0);
        	        String username = (String) session.getAttribute("username");

        	        // Portfolio
        	        List<Cart> lst = crepo.findByUsernameAndStatus(username,"Done");

        	        for (Cart c : lst) {
        	            StockInfo stock = strepo.findBySid(c.getSid());
        	            c.setCurrentRate(stock.getRate());
        	            System.out.println(stock.getRate()+"pfpfp");
        	            
        	        }
        	        m.addAttribute("lst", lst);

        	        // Overall Unrealized P/L
        	        double overallPL = 0;
        	        for (Cart c : lst) {
        	            overallPL +=
        	                (c.getCurrentRate() - c.getRate()) * c.getQuantity();
        	        }
        	        session.setAttribute("total", overallPL);

        	        // Today's P/L (UNREALIZED – temporary)
        	        double todayPL = overallPL;
        	        m.addAttribute("todayPL", todayPL);

        	        return "userHome";
        			
        			
        		}	
        		else {
        			List<Transactions> stlst = new ArrayList<Transactions>();
        	    	List<Transactions> tlst = trepo.findAll();
        	    	System.out.println("tlst"+tlst.get(1));
        	    	
        	    	int stc = (int) strepo.count();
        	    	m.addAttribute("stc",stc);
        	    	int uc = (int)repo.count();
        	    	m.addAttribute("uc",uc);
        	    	System.out.println(uc+"helll"+stc);
        	    	
        	    	List<UserInfo> uspd = repo.findByStatus("Pending");
        	    	System.out.println(uspd.size()+"lll");
        	    	int us = uspd!=null? uspd.size():0;
        	    	m.addAttribute("uspd",us);
        	    	
        	    	for (Transactions transactions : tlst) {
        				if("buy".equals(transactions.getWd()) || "sell".equals(transactions.getWd())) {
        					stlst.add(transactions);
        				}
        			}
        	    	System.out.println("stlst"+stlst.get(1));
        	    	m.addAttribute("stlst",stlst);
        	        return "home";
        			}
        		}
        } else {
            m.addAttribute("msg", "<font color=Red>Invalid Username / Password</font>");
            return "index";
        }
    }

    @GetMapping("/signup")
    public String regPage() {
        return "signup";
    }

    @PostMapping("/register")
    public ModelAndView addUser(@RequestParam("firstname") String fname, @RequestParam("lastname") String lname,
            @RequestParam("email") String email, @RequestParam("contact") String contact,
            @RequestParam("address") String add, @RequestParam("password") String pass,
            @RequestParam("dp") MultipartFile file, Model m) throws Exception {

        UserInfo u = new UserInfo();
        u.setFname(fname);
        u.setLastname(lname);
        u.setEmail(email);
        u.setContact(contact);
        u.setAddress(add);
        u.setPassword(pass);
        u.setImage(file.getOriginalFilename());
        u.setType("Trader");
        u.setStatus("Pending");

        ModelAndView mv;

        // ✅ fixed file save path
        String serverurl = "C:\\Users\\Aayush\\eclipse-workspace\\JeeFinalProj\\Boot\\Boot_FinalProj-1\\src\\main\\resources\\static\\images";
        File serverfile = new File(serverurl + file.getOriginalFilename());
        file.transferTo(serverfile);

        if (repo.save(u) != null) {
        	//ms.sendRegMail(email);
            mv = new ModelAndView("index", "msg", "<font color=green>User Registered Successfully, You Can Login Now</font>");
        } else {
            mv = new ModelAndView("signup", "msg", "<font color=Red>User Already Exists / Could Not Register</font>");
        }

        m.addAttribute("userObj", u);
        return mv;
    }
    
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // 🔥 KILLS session
        }
        return "redirect:/index";
    }

    
  


}
