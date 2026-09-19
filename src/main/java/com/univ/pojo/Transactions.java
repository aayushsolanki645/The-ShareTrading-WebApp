package com.univ.pojo;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;



@Entity
public class Transactions {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int tid = 10;
	private LocalDateTime datetime;
	private String sname = "na";
	private int quantity = 0;
	private double pps = 0.0;
	private double total = 0.0;
	private String type = "na";
	private String username = "na";
	private String via = "na";
	private String wd ;
	private double currtotal = 0.0;
	
	public Transactions() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Transactions(String wd,double currTotal, int tid, LocalDateTime dateTime, String sname, int quantity, double pps, double total,
			String type, String username, String via) {
		super();
		this.wd = wd;
		this.currtotal = currTotal;
		this.tid = tid;
		this.datetime = dateTime;
		this.sname = sname;
		this.quantity = quantity;
		this.pps = pps;
		this.total = total;
		this.type = type;
		this.username = username;
		this.via = via;
	}
	public String getWd() {
		return wd;
	}
	public void setWd(String wd) {
		this.wd = wd;
	}
	public double getCurrTotal() {
		return currtotal;
	}
	public void setCurrTotal(double currTotal) {
		this.currtotal = currTotal;
	}
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public LocalDateTime getDateTime() {
		return datetime;
	}
	public void setDateTime(LocalDateTime dateTime) {
		this.datetime = dateTime;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPps() {
		return pps;
	}
	public void setPps(double pps) {
		this.pps = pps;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getVia() {
		return via;
	}
	public void setVia(String via) {
		this.via = via;
	}
}
