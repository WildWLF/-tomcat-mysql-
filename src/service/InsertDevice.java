package service;

import dao.DeviceDao;
import dao.WarehouseDao;
import vo.device;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;

public class InsertDevice extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int MaxId = Integer.parseInt(req.getParameter("MaxId"));
        int warehouseId = Integer.parseInt(req.getParameter("warehouseId"));
        String DeviceName = req.getParameter("DeviceName");
        String DeviceCode = req.getParameter("DeviceCode");
        String WarehouseName = req.getParameter("WarehouseName");
        String WarehouseCode = req.getParameter("WarehouseCode");
        double TempHighThreshold = Double.parseDouble(req.getParameter("TempHighThreshold"));
        double TempLowThreshold = Double.parseDouble(req.getParameter("TempLowThreshold"));
        double RhHighThreshold = Double.parseDouble(req.getParameter("RhHighThreshold"));
        double RhLowThreshold = Double.parseDouble(req.getParameter("RhLowThreshold"));
        LocalDateTime createdAt = LocalDateTime.now();
        LocalDateTime updatedAt = LocalDateTime.now();
        String createBy = req.getSession().getAttribute("username").toString();
        device device = new device(MaxId + 1,DeviceName,DeviceCode,WarehouseName,WarehouseCode,warehouseId,TempHighThreshold,TempLowThreshold,
                RhHighThreshold,RhLowThreshold,createBy,createdAt,updatedAt);
        DeviceDao deviceDao = new DeviceDao();
        deviceDao.insertDevice(device);
        req.getRequestDispatcher("device.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String WarehouseName = req.getParameter("WarehouseName");
        String WarehouseCode = req.getParameter("WarehouseCode");
        int WarehouseId = -1;
        WarehouseDao warehouseDao = new WarehouseDao();
        WarehouseId = warehouseDao.selectByKey(WarehouseName,WarehouseCode);
        PrintWriter out = resp.getWriter();
        if(WarehouseId == -1){
            out.print("FAILURE");
        }
        else{
            out.print("SUCCESS," + WarehouseId);
        }
    }
}
