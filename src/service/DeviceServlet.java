package service;

import dao.DeviceDao;
import dao.WarehouseDao;
import vo.device;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

public class DeviceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DeviceDao dao = new DeviceDao();
        String deviceName = req.getParameter("deviceName");
        String deviceCode = req.getParameter("deviceCode");
        String warehouseName = req.getParameter("warehouseName");
        String warehouseCode = req.getParameter("warehouseCode");
        List<device> devices = dao.selectDevices(deviceName, deviceCode, warehouseName, warehouseCode);
        req.setAttribute("devices", devices);
        req.getRequestDispatcher("device.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int deviceId = Integer.parseInt(req.getParameter("deviceId"));
        String deviceName = req.getParameter("deviceName");
        String deviceCode = req.getParameter("deviceCode");
        String warehouseName = req.getParameter("warehouseName");
        String warehouseCode = req.getParameter("warehouseCode");
        LocalDateTime updateAt = LocalDateTime.now();
        String updateBy = req.getSession().getAttribute("username").toString();
        double tempHighThreshold = Double.parseDouble(req.getParameter("TempHighThreshold"));
        double tempLowThreshold = Double.parseDouble(req.getParameter("TempLowThreshold"));
        double rhHighThreshold = Double.parseDouble(req.getParameter("RhHighThreshold"));
        double rhLowThreshold = Double.parseDouble(req.getParameter("RhLowThreshold"));
        device dev = new device(deviceId,deviceName,deviceCode,warehouseName,warehouseCode,tempHighThreshold,
                tempLowThreshold,rhHighThreshold,rhLowThreshold,updateBy,updateAt);
        DeviceDao dao = new DeviceDao();
        dao.updateDevice(dev);
        req.getRequestDispatcher("device.jsp").forward(req, resp);
    }
}
