package model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import model.dto.AssetDto;

public class AssetDao {
    // 데이터베이스 연결 관련 변수
    protected Connection conn;

    private String dburl = "jdbc:mysql://localhost:3306/AssetKeeper"; // 연동할 DB 서버 URL
    private String dbuser = "root"; // DB 사용자 계정명
    private String dbpwd = "1234"; // DB 비밀번호

    // 생성자: 데이터베이스 연결 초기화
    public AssetDao() {
        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 데이터베이스 연결
            conn = DriverManager.getConnection(dburl, dbuser, dbpwd);
            System.out.println("[DB 연결 성공]");
        } catch (Exception e) {
            System.out.println("[DB 연동 실패]: " + e.getMessage());
        }
    }

    // 싱글톤 패턴
    @Getter
    private static AssetDao instance = new AssetDao();

    // 비품 등록 처리 메소드
    public boolean insertAsset(AssetDto assetDto) { // 인설트에셋
        String sql = "INSERT INTO assets (name, manager, purchasePlace, purchaseDate, purchasePrice, currentLocation, specialNotes) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            // SQL 문에 매개변수 값 설정
            ps.setString(1, assetDto.getName());
            ps.setString(2, assetDto.getManager());
            ps.setString(3, assetDto.getPurchasePlace());
            ps.setDate(4, Date.valueOf(assetDto.getPurchaseDate())); // LocalDate -> java.sql.Date 변환
            ps.setDouble(5, assetDto.getPurchasePrice());
            ps.setString(6, assetDto.getCurrentLocation());
            ps.setString(7, assetDto.getSpecialNotes());

            // SQL 실행 및 결과 반환
            int rowsInserted = ps.executeUpdate(); // 성공적으로 삽입된 행 수를 반환
            return rowsInserted > 0; // 삽입된 행이 1개 이상이면 true 반환
        } catch (Exception e) {
            System.out.println("[insertAsset 오류]: " + e.getMessage());
        }
        return false; // 삽입 실패 시 false 반환
    }

    // 비품 전체 조회 처리 메소드
    public List<AssetDto> getAllAssets() { // 겟 올 어셋츠
        List<AssetDto> assets = new ArrayList<>();
        String sql = "SELECT * FROM assets order by id desc";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AssetDto asset = new AssetDto(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("manager"),
                    rs.getString("purchasePlace"),
                    rs.getString("purchaseDate"), // String으로 반환
                    rs.getDouble("purchasePrice"),
                    rs.getString("currentLocation"),
                    rs.getString("specialNotes")
                );
                assets.add(asset);
            }
        } catch (Exception e) {
            System.out.println("[getAllAssets 오류]: " + e.getMessage());
        }
        return assets;
    }
    
    // 비품 개별 수정 처리 메소드
    public boolean updateAsset(AssetDto assetDto) {
        try {
            String sql = "UPDATE assets SET name = ?, manager = ?, purchasePlace = ?, purchaseDate = ?, purchasePrice = ?, currentLocation = ?, specialNotes = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, assetDto.getName());
            ps.setString(2, assetDto.getManager());
            ps.setString(3, assetDto.getPurchasePlace());
            ps.setString(4, assetDto.getPurchaseDate());
            ps.setDouble(5, assetDto.getPurchasePrice());
            ps.setString(6, assetDto.getCurrentLocation());
            ps.setString(7, assetDto.getSpecialNotes());
            ps.setInt(8, assetDto.getId());

            int count = ps.executeUpdate();
            if (count == 1) {
                System.out.println("비품 수정 성공: " + assetDto.getId());
                return true;
            } else {
                System.out.println("비품 수정 실패: ID가 존재하지 않거나 잘못됨.");
                return false;
            }
        } catch (Exception e) {
            System.out.println("비품 수정 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // 비품 삭제 처리 메소드
    public boolean deleteAsset(int id) {
    	try {
			String sql = "delete from assets where id =?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			int count = ps.executeUpdate();
			if(count ==1)return true;
		} catch (Exception e) {System.out.println(e);
			// TODO: handle exception
		}
        return false;
    }
    
    // 비품 개별 조회 처리 메소드
    public AssetDto getReadAsset(int id) {
		try {
			String sql = "select * from assets where id = ? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if( rs.next()) {
				AssetDto assetDto = new AssetDto();
				assetDto.setId(rs.getInt("id"));
				assetDto.setName(rs.getString("name"));
				assetDto.setPurchaseDate(rs.getString("purchaseDate"));
				return assetDto;
			}
		} catch (Exception e) {System.out.println(e);}
		return null;
	}



}

