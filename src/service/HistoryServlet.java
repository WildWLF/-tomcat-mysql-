package service;

import dao.HistoryDao;
import vo.history;
import vo.pagination;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String deviceName = req.getParameter("deviceName");
        String deviceCode = req.getParameter("deviceCode");
        String warehouseName = req.getParameter("warehouseName");
        String warehouseCode = req.getParameter("warehouseCode");
        String startTime = req.getParameter("startTime");
        String endTime = req.getParameter("endTime");
        int pageSize = Integer.parseInt(req.getParameter("pageSize") != null ? req.getParameter("pageSize") : "10");
        int currentPage = Integer.parseInt(req.getParameter("page") != null ? req.getParameter("page") : "1");
        if(startTime == null || startTime.isEmpty())
        {
            startTime = "2024-01-01T00:00";
        }
        if(endTime == null || endTime.isEmpty())
        {
            endTime = "2024-12-31T23:59";
        }
        System.out.println(startTime);
        history history = new history(warehouseName,warehouseCode,deviceName,deviceCode);
        HistoryDao historyDao = new HistoryDao();
        List<Map<String, Object>> allData = historyDao.selectHistory(history,startTime,endTime);

        int totalRecords = allData.size();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        int fromIndex = (currentPage - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalRecords);
        List<Map<String, Object>> pagedData = allData.subList(fromIndex, toIndex);

        req.setAttribute("allData", allData);
        req.setAttribute("dataList", pagedData);
        req.setAttribute("pagination", new pagination(currentPage, pageSize, totalRecords, totalPages));
        req.getRequestDispatcher("/history.jsp").forward(req, resp);
    }
}
