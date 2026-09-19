package com.univ.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.univ.daoimpl.DaoImpl;
import com.univ.daoimpl.TransactionDaoImpl;
import com.univ.pojo.Account;
import com.univ.pojo.Cart;
import com.univ.pojo.StockInfo;
import com.univ.pojo.Transactions;
import com.univ.repo.AccRepo;
import com.univ.repo.CartRepo;
import com.univ.repo.StockInfoRepo;
import com.univ.repo.TransactionsRepo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class TransactionControl {

    private final MailSender otpMailService;
	
	@Autowired
	private TransactionDaoImpl traDao;
	
	@Autowired
	private DaoImpl daoImpl;
	
	@Autowired
	private TransactionsRepo trepo;
	
	@Autowired
	private CartRepo crepo;
	
	@Autowired
	private StockInfoRepo strepo;
	
	@Autowired
	private AccRepo acrepo;


    TransactionControl(MailSender otpMailService) {
        this.otpMailService = otpMailService;
    }
	
	
	@GetMapping("/transactionDetails")
    public String transactionDetails(@RequestParam("id") int id, Model model) {
        Transactions user = trepo.findByTid(id); 
        model.addAttribute("transaction", user);
        return "transactionDetails";
    }
	
	@PostMapping("/addBankAccount")
    public String addAccDetails(@RequestParam("bankName") String bankName,
    							@RequestParam("holder") String holder,
    							@RequestParam("accountNo") String accountNo,
    							@RequestParam("ifsc") String ifsc,
    							@RequestParam("branch") String branch,
    							Model m,HttpServletRequest request) {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("username"); 
		Account ac = new Account();
		ac.setBname(bankName);
		ac.setHname(holder);
		ac.setAcno(accountNo);
		ac.setIfsc(ifsc);
		ac.setBranch(branch);
		ac.setUsername(user);
		if(acrepo.save(ac) != null) {
			m.addAttribute("Account Added!","acc");
			List<Transactions> trans;
        	trans = trepo.findByUsername((String)session.getAttribute("username"));
        	if(trans.isEmpty()==false)
        	{
        	Transactions t = trans.get(trans.size()-1);
        	session.setAttribute("cuuTotal", t.getCurrTotal());
        	m.addAttribute("trans",trans);
        	}else {
        		session.setAttribute("cuuTotal", 0.0);
        		}
			return "addMoney";
		}
		m.addAttribute("Failed","acc");
        return "bankDetails";
    }
	
	@GetMapping("/bankDetails")
    public String bankDetails() {
        return "bankDetails";
    }
	
	@PostMapping("/addbalance")
    public ModelAndView addStocks(@RequestParam("s1") String cname,
    		@RequestParam("amount") Double rate,
    		@RequestParam("b1") String button ,Model m,HttpServletRequest request ) throws Exception {
		HttpSession session = request.getSession();
		
		ModelAndView mv;
		
        List<Transactions> lst = (List<Transactions>) trepo.findByUsername((String)session.
        					getAttribute("username"));
        Transactions t = new Transactions();
        if(lst.isEmpty()==false)
        {
         t =lst.get(lst.size()-1);
        }
        LocalDateTime l = LocalDateTime.now();
        t.setDateTime(l);
        t.setVia(cname);
        t.setTotal(rate);
        
        
        if("deposit".equalsIgnoreCase(button))
        {
        	t.setCurrTotal(rate+t.getCurrTotal());
        	t.setSname("Deposit");
        	t.setQuantity(0);
        	t.setPps(0);
        	t.setWd("deposit");
        	System.out.println(t.getCurrTotal()+"ass");
        }
        else if("withdraw".equalsIgnoreCase(button))
        {
        	if(t.getCurrTotal()>rate)
        	{
        	t.setCurrTotal(t.getCurrTotal()-rate);
        	t.setSname("withdraw");
        	t.setQuantity(0);
        	t.setPps(0);
        	t.setWd("withdraw");
        	}else {
        		mv = new ModelAndView("addMoney", "msg", "Withdrawl Amount is greater"
        				+ " to Available Amount");
        	}
        }
        else
        	t.setCurrTotal(t.getCurrTotal()-rate);
        
        t.setUsername((String)session.getAttribute("username"));

        

        if (trepo.save(t) != null) {
            mv = new ModelAndView("addMoney", "msg", "Amount Deposit/Withdrawl Successfully");
        } else {
            mv = new ModelAndView("addMoney", "msg", "Can Not Deposit/Withdrawl Amount");
        }

       
		  return mv;
    }
	
	
	
	@GetMapping("/transactions")
    public String transactions(Model m,HttpServletRequest request ) throws Exception {
		HttpSession session = request.getSession();
        List<Transactions> lst = (List<Transactions>) trepo.findByUsername((String)session.
        					getAttribute("username"));
        List<Transactions> withdraw = new ArrayList<Transactions>();
        List<Transactions> deposit= new ArrayList<Transactions>();
        List<Transactions> buy= new ArrayList<Transactions>();
        List<Transactions> sell= new ArrayList<Transactions>();
        
        for (Transactions transactions : lst) {
			if( "withdraw".equalsIgnoreCase(transactions.getWd()))
				withdraw.add(transactions);
			if( "deposit".equalsIgnoreCase(transactions.getWd()))
				deposit.add(transactions);
			if( "buy".equalsIgnoreCase(transactions.getWd()))
				buy.add(transactions);
			if( "sell".equalsIgnoreCase(transactions.getWd()))
				sell.add(transactions);
		}
        System.out.println(buy.isEmpty()+"lll");
        session.setAttribute("w", withdraw);
        session.setAttribute("lst", lst);
        session.setAttribute("d", deposit);
        session.setAttribute("b", buy);
        session.setAttribute("s", sell);
        return "transactions";
    }
	
	/** ✅ Manage Users + Stocks Page **/
    @GetMapping("/addMoney")
    public String addbalance(Model m,HttpServletRequest request) {
    		List<Transactions> trans;
    		HttpSession session = request.getSession();
    		
    		Account ac = acrepo.findByUsername((String)session.getAttribute("username"));
    		if(ac!=null) {
    		
        	trans = trepo.findByUsername((String)session.getAttribute("username"));
        	if(trans.isEmpty()==false)
        	{
        	Transactions t = trans.get(trans.size()-1);
        	session.setAttribute("cuuTotal", t.getCurrTotal());
        	m.addAttribute("trans",trans);
        	}else {
        		session.setAttribute("cuuTotal", 0.0);
        		}
        	return "addMoney";
    		}
    		else {
    			return "bankDetails";
    		}
        }
    
    @PostMapping("/cartAction")
    public String cartAction(
    		@RequestParam("cid") int cid,
    		@RequestParam("sid") int sid,
    		@RequestParam("btn") String btn,
    		@RequestParam("status") String status,HttpServletRequest request,Model m
    		) {
    	HttpSession session = request.getSession();
    	session.setAttribute("cid", cid);
    	Cart t = crepo.findByCid(cid);
    	StockInfo st = strepo.findBySid(sid);
    	Transactions t2 = trepo.findTopByUsernameOrderByTidDesc((String)session
    			.getAttribute("username"));
    	if("remove".equalsIgnoreCase(btn))
    	{
    			crepo.delete(t);
    			return "cart";
    	}
    	
    	if("buy".equalsIgnoreCase(btn))
    	{	
    		if(t2 != null) {
    		
    		if(t2.getCurrTotal()>(t.getQuantity()*st.getRate())) {
    		t.setStatus("Done");
    		st.setAvailableStocks(st.getAvailableStocks() - t.getQuantity());
    		st.setLiquid(st.getLiquid()+(t.getQuantity()*st.getRate()));
    		LocalDateTime ld = LocalDateTime.now();
    		Transactions tt = new Transactions();
    		tt.setDateTime(ld);
    		tt.setSname(st.getSname());
    		tt.setPps(st.getRate());
    		tt.setQuantity(t.getQuantity());
    		tt.setUsername((String)session.getAttribute("username"));
    		tt.setTotal(st.getRate()*t.getQuantity());
    		tt.setWd("buy");
    		tt.setVia(status);
    		System.out.println(t2.getCurrTotal()-(st.getRate()*t.getQuantity()));
    		tt.setCurrTotal(t2.getCurrTotal()-(st.getRate()*t.getQuantity()));
    		if(strepo.save(st) != null && crepo.save(t) != null && trepo.save(tt) != null) {
    			otpMailService.sendPurchaseMail((String)session.getAttribute("username"), st);
    			return "cart";
    		}
    			
    		}else
    		{	
    			request.setAttribute("msg", "Insufficient Balance");
    			return "cart";
    		}
    	}
    		else {
    			request.setAttribute("msg", "You Do Not Have Balance in Your Acc!");
    			return "cart";
    			}
    	}
    	return "pending";
    }
    
    

}
