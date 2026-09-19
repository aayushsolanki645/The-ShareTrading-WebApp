package com.univ.pojo;



import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="cart")
public class Cart {
	
	@Id
	private int cid;
	private int sid;
	private String sname;
	private double rate;
	private double currentrate;
	private double total;
	private int quantity=0;
	private String dp;
	private String username;
	private String status = "Pending";
	public int getCid() {
		return cid;
	}
	
	// Cart.java
	

	public double getCurrentRate() {
	    return currentrate;
	}
	public void setCurrentRate(double currentRate) {
	    this.currentrate = currentRate;
	}

	
	public void setCid(int cid) {
		this.cid = cid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	
	public Cart(String status ,String dp,int sid, String sname, double rate, double total, int quantity, String username) {
		super();
		this.status = status;
		this.dp=dp;
		this.sid = sid;
		this.sname = sname;
		this.rate = rate;
		this.quantity=quantity;
		this.total=total;
		this.username=username;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getDp() {
		return dp;
	}
	public void setDp(String dp) {
		this.dp = dp;
	}
	public Cart() {
		super();
		// TODO Auto-generated constructor stub
	} 
}
