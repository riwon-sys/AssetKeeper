package controller;

import java.io.BufferedReader;
import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.AssetDao;
import model.dto.AssetDto;

@WebServlet("/asset")
public class AssetController extends HttpServlet {
	
	
	// [1] 비품 전산 등록
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    System.out.println("asset post ok!!!");
	    
	    try {
	        ObjectMapper mapper = new ObjectMapper();
	        AssetDto assetDto = mapper.readValue(req.getReader(), AssetDto.class);

	        boolean result = AssetDao.getInstance().insertAsset(assetDto);

	        if (result) {
	            resp.setStatus(HttpServletResponse.SC_CREATED);
	            resp.getWriter().print("{\"message\":\"비품 등록 성공\"}");
	        } else {
	            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            resp.getWriter().print("{\"message\":\"비품 등록 실패\"}");
	        }
	    } catch (Exception e) {
	        System.out.println("비품 등록 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	    }
	}

	// [2] 비품 전산 전체조회
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    System.out.println("asset get ok!!!");

	    // DAO를 통해 모든 비품 조회
	    ObjectMapper mapper = new ObjectMapper();
	    try {
	        resp.setContentType("application/json");
	        resp.setCharacterEncoding("UTF-8");

	        // 데이터베이스에서 모든 비품 정보 가져오기
	        resp.getWriter().write(mapper.writeValueAsString(AssetDao.getInstance().getAllAssets()));
	        resp.setStatus(HttpServletResponse.SC_OK); // 200 OK
	    } catch (Exception e) {
	        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Error
	        resp.getWriter().write("{\"message\":\"비품 조회 실패\"}");
	    }
	}
	
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    resp.setContentType("application/json");
	    resp.setCharacterEncoding("UTF-8");

	    try {
	        // JSON 데이터를 Java 객체로 변환
	        ObjectMapper mapper = new ObjectMapper();
	        AssetDto assetDto = mapper.readValue(req.getInputStream(), AssetDto.class);

	        System.out.println("비품 수정 요청 데이터: " + assetDto.toString()); // 디버깅 로그 추가

	        boolean result = AssetDao.getInstance().updateAsset(assetDto);

	        if (result) {
	            resp.setStatus(HttpServletResponse.SC_OK);
	            resp.getWriter().print("{\"message\":\"비품 수정 성공\"}");
	            System.out.println("비품 수정 성공!");
	        } else {
	            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            resp.getWriter().print("{\"message\":\"비품 수정 실패\"}");
	            System.out.println("비품 수정 실패!");
	        }

	    } catch (Exception e) {
	        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        resp.getWriter().print("{\"message\":\"서버 오류\"}");
	        System.out.println("비품 수정 중 오류 발생: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
	
	// [4] 비품 전산 삭제
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("asset delete ok!!!");
		
		int id = Integer.parseInt(req.getParameter("id")); // 파라미터 - 쿼리스트링
		
		boolean result = AssetDao.getInstance().deleteAsset(id);
		
		 resp.setContentType("application/json");
		 resp.getWriter().print(result);
	
	}
	
	
}
