package com.univ.daoimpl;

import java.util.List;
import java.util.Optional;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.univ.dao.UserDao;
import com.univ.pojo.StockInfo;
import com.univ.pojo.UserInfo;
import com.univ.repo.StockInfoRepo;
import com.univ.repo.UserInfoRepo;

@Repository
@Transactional
public class DaoImpl implements UserDao {

    @PersistenceContext
    private EntityManager entityManager;
    
    @Autowired
    private UserInfoRepo repo;

    /** ✅ LOGIN CHECK **/
    @Override
    public UserInfo checkUser(UserInfo u) {
		
		 List<UserInfo> list = entityManager.createQuery(
		  "from UserInfo where email = :email and password = :pass", UserInfo.class )
		 .setParameter("email", u.getEmail()) .setParameter("pass", u.getPassword())
		 .getResultList();
		 
		 return list.isEmpty() ? null : list.get(0);
		 
    	
    }

    /** ✅ ADD USER **/
    @Override
    public boolean addUser(UserInfo u) {
        try {
        	repo.save(u);
        	return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ ADD STOCK **/
    public boolean addStock(StockInfo u) {
        try {
            entityManager.persist(u);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ UPDATE USER **/
    public boolean updateUser(UserInfo a) {
        try {
            entityManager.merge(a);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ UPDATE STOCK **/
    public boolean updateStocks(StockInfo a) {
        try {
            entityManager.merge(a);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ DELETE USER **/
    public boolean deleteUser(UserInfo a) {
        try {
            entityManager.remove(
                entityManager.contains(a) ? a : entityManager.merge(a)
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ DELETE STOCK **/
    public boolean deleteStocks(StockInfo a) {
        try {
            entityManager.remove(
                entityManager.contains(a) ? a : entityManager.merge(a)
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ USER SEARCH **/
    public List<UserInfo> searchUser(String query) {
        return entityManager.createQuery(
            "from UserInfo where lower(fname) like :q " +
            "or lower(lastname) like :q " +
            "or lower(email) like :q",
            UserInfo.class
        )
        .setParameter("q", "%" + query.toLowerCase() + "%")
        .getResultList();
    }

    /** ✅ PENDING USER SEARCH **/
    public List<UserInfo> searchpendingUser() {
        return entityManager.createQuery(
            "from UserInfo where status = :status",
            UserInfo.class
        )
        .setParameter("status", "Pending")
        .getResultList();
    }

    /** ✅ STOCK SEARCH **/
    public List<StockInfo> searchStock(String query) {
        return entityManager.createQuery(
            "from StockInfo where lower(sname) like :q",
            StockInfo.class
        )
        .setParameter("q", "%" + query.toLowerCase() + "%")
        .getResultList();
    }

    /** ✅ STOCK SEARCH BY NAME **/
    public List<StockInfo> searchStockViaName(String query) {
        return entityManager.createQuery(
            "from StockInfo where lower(sname) = :q",
            StockInfo.class
        )
        .setParameter("q", query.toLowerCase())
        .getResultList();
    }

    /** ✅ FETCH ALL USERS **/
    public List<UserInfo> getAllUsers() {
        return entityManager.createQuery(
            "from UserInfo",
            UserInfo.class
        ).getResultList();
    }

    /** ✅ FETCH ALL STOCKS **/
    public List<StockInfo> getAllStocks() {
        return entityManager.createQuery(
            "from StockInfo",
            StockInfo.class
        ).getResultList();
    }

    /** ✅ FETCH USER BY ID **/
    public UserInfo getUserById(int id) {
        return entityManager.find(UserInfo.class, id);
    }

    /** ✅ FETCH STOCK BY ID **/
    public StockInfo getStockById(int id) {
        return entityManager.find(StockInfo.class, id);
    }

    /** ✅ COUNT STOCK RECORDS **/
    public int countAllStockRecords() {
        Long count = entityManager.createQuery(
            "select count(s) from StockInfo s",
            Long.class
        ).getSingleResult();
        return count.intValue();
    }

    /** ✅ COUNT USER RECORDS **/
    public int countAllUserRecords() {
        Long count = entityManager.createQuery(
            "select count(u) from UserInfo u",
            Long.class
        ).getSingleResult();
        return count.intValue();
    }
}
