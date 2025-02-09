package service;

import dao.WarehouseDao;
import vo.warehouse;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

public class InsertWarehouse extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int MaxId = Integer.parseInt(req.getParameter("MaxId"));
        String WarehouseName = req.getParameter("WarehouseName");
        String WarehouseCode = req.getParameter("WarehouseCode");
        LocalDateTime createdAt = LocalDateTime.now();
        LocalDateTime updatedAt = LocalDateTime.now();
        String createBy = req.getSession().getAttribute("username").toString();
        warehouse warehouse = new warehouse(MaxId + 1,WarehouseName,WarehouseCode,createBy,createdAt,updatedAt);
        WarehouseDao warehouseDao = new WarehouseDao();
        warehouseDao.insertWarehouse(warehouse);
        req.getRequestDispatcher("warehouse.jsp").forward(req, resp);
    }
}
