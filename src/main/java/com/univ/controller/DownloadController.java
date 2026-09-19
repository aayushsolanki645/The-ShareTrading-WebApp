package com.univ.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.univ.pojo.StockInfo;
import com.univ.pojo.Transactions;
import com.univ.pojo.UserInfo;
import com.univ.repo.StockInfoRepo;
import com.univ.repo.TransactionsRepo;
import com.univ.repo.UserInfoRepo;


@Controller
public class DownloadController {
	
	@Autowired
	private TransactionsRepo trepo;
	
	@Autowired
	private UserInfoRepo repo;
	
	@Autowired
	private StockInfoRepo strepo;
	
	@GetMapping("/downloadAllUserList")
	public void downloadUserList(HttpServletResponse response,
	                           HttpSession session) throws Exception {

	    String username = (String) session.getAttribute("username");

	    List<UserInfo> lst =
	            repo.findAll();

	    // Set response headers
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition",
	            "attachment; filename=ShareTrade_Report.pdf");

	    // Create PDF
	    Document document = new Document();
	    PdfWriter.getInstance(document, response.getOutputStream());

	    document.open();

	    // Title
	    Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
	    Paragraph title = new Paragraph("ShareTrade All Customer List\n\n", titleFont);
	    title.setAlignment(Element.ALIGN_CENTER);
	    document.add(title);

	    // User info
	    document.add(new Paragraph("Username: " + "Admin"));
	    document.add(new Paragraph("Generated on: " + new Date()));
	    document.add(new Paragraph("\n"));

	    // Table
	    PdfPTable table = new PdfPTable(5);
	    table.setWidthPercentage(100);

	    table.addCell("FirstName");
	    table.addCell("LastName");
	    table.addCell("Email");
	    table.addCell("Address");
	    table.addCell("Contact");

	    for (UserInfo t : lst) {
	        table.addCell(t.getFname());
	        table.addCell(t.getLname());
	        table.addCell(t.getEmail());
	        table.addCell(t.getAddress());
	        table.addCell(t.getContact());
	    }

	    document.add(table);
	    document.close();
	}
	
	@GetMapping("/downloadAllStockList")
	public void downloadStocksList(HttpServletResponse response,
	                           HttpSession session) throws Exception {

	    String username = (String) session.getAttribute("username");

	    List<StockInfo> lst =
	            strepo.findAll();

	    // Set response headers
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition",
	            "attachment; filename=ShareTrade_Report.pdf");

	    // Create PDF
	    Document document = new Document();
	    PdfWriter.getInstance(document, response.getOutputStream());

	    document.open();

	    // Title
	    Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
	    Paragraph title = new Paragraph("ShareTrade All Stocks List\n\n", titleFont);
	    title.setAlignment(Element.ALIGN_CENTER);
	    document.add(title);

	    // User info
	    document.add(new Paragraph("Username: " + "Admin"));
	    document.add(new Paragraph("Generated on: " + new Date()));
	    document.add(new Paragraph("\n"));

	    // Table
	    PdfPTable table = new PdfPTable(5);
	    table.setWidthPercentage(100);

	    table.addCell("Stock Name");
	    table.addCell("Availablke Stocks");
	    table.addCell("Rate");
	    table.addCell("Stock ID");

	    for (StockInfo t : lst) {
	        table.addCell(t.getSname());
	        table.addCell( String.valueOf( t.getAvailableStocks()));
	        table.addCell(String.valueOf(t.getRate()));
	        table.addCell(String.valueOf(t.getSid()));
	    }

	    document.add(table);
	    document.close();
	}

	@GetMapping("/downloadReport")
	public void downloadReport(HttpServletResponse response,
	                           HttpSession session) throws Exception {

	    String username = (String) session.getAttribute("username");

	    List<Transactions> transactions =
	            trepo.findByUsername(username);

	    // Set response headers
	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition",
	            "attachment; filename=ShareTrade_Report.pdf");

	    // Create PDF
	    Document document = new Document();
	    PdfWriter.getInstance(document, response.getOutputStream());

	    document.open();

	    // Title
	    Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
	    Paragraph title = new Paragraph("ShareTrade Transaction Report\n\n", titleFont);
	    title.setAlignment(Element.ALIGN_CENTER);
	    document.add(title);

	    // User info
	    document.add(new Paragraph("Username: " + username));
	    document.add(new Paragraph("Generated on: " + new Date()));
	    document.add(new Paragraph("\n"));

	    // Table
	    PdfPTable table = new PdfPTable(6);
	    table.setWidthPercentage(100);

	    table.addCell("Date & Time");
	    table.addCell("Type");
	    table.addCell("Amount");
	    table.addCell("Via");
	    table.addCell("Stock Name");
	    table.addCell("Stock Quantity");

	    for (Transactions t : transactions) {
	        table.addCell(t.getDateTime().toString());
	        table.addCell(t.getType());
	        table.addCell("₹ " + t.getTotal());
	        table.addCell("₹ " + t.getVia());
	        table.addCell("₹ " + t.getSname());
	        table.addCell("₹ " + t.getQuantity());
	    }

	    document.add(table);
	    document.close();
	}
}
