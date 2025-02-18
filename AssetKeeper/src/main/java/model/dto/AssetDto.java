package model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor@AllArgsConstructor
@Getter@Setter@ToString
public class AssetDto {
	private int id; // 비품의 고유 ID(관리번호)
	private String name; //비품명
	private String manager; // 비품 관리자
	private String  purchasePlace; // 비품 구입처
	private String  purchaseDate; // 비품 구입일자
	private double  purchasePrice; // 비품 가격
    private String currentLocation; // 비품 현 위치
    private String specialNotes; // 특이사항
}
