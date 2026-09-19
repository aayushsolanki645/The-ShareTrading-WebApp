package com.univ.pojo;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;



@Entity
@Table(name="userinfo")
public class UserInfo {
	@Id
	private int uid;
	private String image;
	private String fname;
	private String lname;
	
	@Column(unique = true)
	private String email;
	
	private String contact;
	private String Address;
	private String password;
	private String type;
	private String status;
	
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLastname(String lname) {
		this.lname = lname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getAddress() {
		return Address;
	}

	public void setAddress(String address) {
		Address = address;
	}

	public UserInfo(String status,String type,int uid,String password,String image, String fname, String lastname, String email, String contact, String address,
			Date date) {
		super();
		this.status = status;
		this.type=type;
		this.uid=uid;
		this.image = image;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.contact = contact;
		this.password=password;
		this.Address = address;
	}

	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public UserInfo() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "UserInfo [uid=" + uid + ", image=" + image + ", fname=" + fname + ", lastname=" + lname + ", email="
				+ email + ", contact=" + contact + ", Address=" + Address + ", password=" + password + "]";
	}
	
	
}
