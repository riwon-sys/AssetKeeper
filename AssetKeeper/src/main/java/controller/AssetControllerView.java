package controller;

import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.AssetDao;
import model.dto.AssetDto;

@WebServlet("/asset/view")
public class AssetControllerView extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("asset|view get ok!!!");
		
		int id = Integer.parseInt(req.getParameter("id"));
		
		AssetDto assetDto = AssetDao.getInstance().getReadAsset(id);
		
		ObjectMapper mapper = new ObjectMapper();
		String jsonstrString = mapper.writeValueAsString(assetDto);
		resp.setContentType("application/json");
		resp.getWriter().print(jsonstrString);
		
		
	}

}
