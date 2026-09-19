package com.univ.pojo;



import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="stockinfo")
public class StockInfo {
	
	@Id
	private int sid;
	private String sname;
	private double rate;
	private String availability;
	
	private int availablestocks;
	private String dp;
	private double liquid=0.0;
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
	public String getAvailability() {
		return availability;
	}
	public void setAvailability(String availability) {
		this.availability = availability;
	}
	public int getAvailableStocks() {
		return availablestocks;
	}
	public void setAvailableStocks(int availableStocks) {
		this.availablestocks = availableStocks;
	}
	public StockInfo(String dp,int sid, String sname, double rate, double liquid, String availability, int availableStocks) {
		super();
		this.dp=dp;
		this.liquid = liquid;
		this.sid = sid;
		this.sname = sname;
		this.rate = rate;
		this.availability = availability;
		this.availablestocks = availableStocks;
	}
	public double getLiquid() {
		return liquid;
	}
	public void setLiquid(double liquid) {
		this.liquid = liquid;
	}
	public String getDp() {
		return dp;
	}
	public void setDp(String dp) {
		this.dp = dp;
	}
	public StockInfo() {
		super();
		// TODO Auto-generated constructor stub
	} 
}
