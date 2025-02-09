package service;

import dao.WarehouseDao;
import vo.warehouse;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class WarehouseServlet extends HttpServlet {

    //模糊查询
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        WarehouseDao warehouseDao = new WarehouseDao();
        String WarehouseName = req.getParameter("WarehouseName");
        String WarehouseCode = req.getParameter("WarehouseCode");
        List<warehouse> warehouses = warehouseDao.selectWarehouse(WarehouseName, WarehouseCode);
        req.setAttribute("warehouses", warehouses);
        req.getRequestDispatcher("warehouse.jsp").forward(req, resp);
    }

    //修改仓库内容
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int WarehouseId = Integer.parseInt(req.getParameter("WarehouseId"));
        String WarehouseName = req.getParameter("WarehouseName");
        String WarehouseCode = req.getParameter("WarehouseCode");
        LocalDateTime updateAt = LocalDateTime.now();
        String updateBy = req.getSession().getAttribute("username").toString();
        warehouse warehouse = new warehouse(WarehouseId,WarehouseName,WarehouseCode,updateBy,updateAt);
        WarehouseDao warehouseDao = new WarehouseDao();
        warehouseDao.UpdateWarehouse(warehouse);
        req.getRequestDispatcher("warehouse.jsp").forward(req, resp);
    }

}
