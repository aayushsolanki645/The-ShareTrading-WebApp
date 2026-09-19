package com.univ.daoimpl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.univ.pojo.Cart;
import com.univ.pojo.StockInfo;
import com.univ.pojo.Transactions;

@Repository
@Transactional
public class TransactionDaoImpl {

    @PersistenceContext
    private EntityManager entityManager;

    private final DaoImpl di;

    public TransactionDaoImpl(DaoImpl di) {
        this.di = di;
    }

    /** ✅ Do Transaction **/
    public boolean addTransaction(Transactions t, Model m) {
        try {
            entityManager.persist(t);
            m.addAttribute("tObject", t);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Transactions getTransactionById(int id) {
        return entityManager.find(Transactions.class, id);
    }

    public List<Transactions> getAllTransactions() {
        return entityManager.createQuery(
            "from Transactions", Transactions.class
        ).getResultList();
    }

    public List<Transactions> searchTransactionViaUsername(String query) {
        return entityManager.createQuery(
            "from Transactions where lower(username) like :q",
            Transactions.class
        )
        .setParameter("q", "%" + query.toLowerCase() + "%")
        .getResultList();
    }

    public List<Transactions> searchTransactionsByUserAndStock(String username, String stockName) {
        return entityManager.createQuery(
            "from Transactions where lower(username) like :u and lower(stockName) like :s",
            Transactions.class
        )
        .setParameter("u", "%" + username.toLowerCase() + "%")
        .setParameter("s", "%" + stockName.toLowerCase() + "%")
        .getResultList();
    }

    /** ✅ ADD Cart **/
    public boolean addToCart(Cart u) {
        try {
            entityManager.persist(u);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /** ✅ UPDATE Cart **/
    public boolean updateCart(Cart u) {
        try {
            entityManager.merge(u);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cart> getAllCart() {
        return entityManager.createQuery(
            "from Cart", Cart.class
        ).getResultList();
    }

    public List<Cart> searchCartViaUsername(String username) {
        return entityManager.createQuery(
            "from Cart where username = :u and status = :s",
            Cart.class
        )
        .setParameter("u", username)
        .setParameter("s", "Pending")
        .getResultList();
    }

    public List<Cart> searchSoldViaUsername(String username) {
        return entityManager.createQuery(
            "from Cart where username = :u and status = :s",
            Cart.class
        )
        .setParameter("u", username)
        .setParameter("s", "Done")
        .getResultList();
    }

    public List<Cart> searchSoldViaUsernameAndStockName(String user, String sname) {
        return entityManager.createQuery(
            "from Cart where username = :u and status = :s and sname = :sn",
            Cart.class
        )
        .setParameter("u", user)
        .setParameter("s", "Done")
        .setParameter("sn", sname)
        .getResultList();
    }

    /** ✅ DELETE Cart **/
    public boolean deleteCart(Cart a) {
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

    public List<Cart> searchCartViaCartId(int id) {
        return entityManager.createQuery(
            "from Cart where cid = :id",
            Cart.class
        )
        .setParameter("id", id)
        .getResultList();
    }

    /** ✅ PROFIT / LOSS (per stock) **/
    public double calculateProfitLoss(String username, String stockName) {

        List<Transactions> list =
            searchTransactionsByUserAndStock(username, stockName);

        if (list == null || list.isEmpty()) return 0.0;

        Transactions lastBuy = null;
        for (int i = list.size() - 1; i >= 0; i--) {
            if ("buy".equalsIgnoreCase(list.get(i).getWd())) {
                lastBuy = list.get(i);
                break;
            }
        }

        if (lastBuy == null) return 0.0;

        double buyPrice = lastBuy.getPps();
        int quantity = lastBuy.getQuantity();

        StockInfo stock = di.searchStockViaName(stockName)
                            .stream()
                            .findFirst()
                            .orElse(null);

        if (stock == null) return 0.0;

        return (stock.getRate() - buyPrice) * quantity;
    }

    public List<String> getAllUsersWhoHaveStock(String user) {
        return entityManager.createQuery(
            "select distinct c.username from Cart c where c.username = :u and c.status = :s",
            String.class
        )
        .setParameter("u", user)
        .setParameter("s", "Done")
        .getResultList();
    }

    public Transactions getLastTransaction(String username) {
        return entityManager.createQuery(
            "from Transactions t where t.username = :u order by t.id desc",
            Transactions.class
        )
        .setParameter("u", username)
        .setMaxResults(1)
        .getResultStream()
        .findFirst()
        .orElse(null);
    }

    public List<Transactions> getBuyTransactionsByStock(String sname) {
        return entityManager.createQuery(
            "from Transactions t where t.sname = :s and t.wd = :type",
            Transactions.class
        )
        .setParameter("s", sname)
        .setParameter("type", "buy")
        .getResultList();
    }

    /** ✅ TOTAL PROFIT / LOSS **/
    public double getProfitLoss(String username) {

        List<Cart> carts = searchSoldViaUsername(username);
        double totalPL = 0;

        for (Cart c : carts) {
            StockInfo stock = di.getStockById(c.getSid());
            totalPL += (stock.getRate() - c.getRate()) * c.getQuantity();
        }

        return totalPL;
    }
}
