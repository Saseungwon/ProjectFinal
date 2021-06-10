package com.nextit.board.vo;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class BoardVO {

	private int    boNo;                    /*글 번호*/
	private String boCate;                  /*게시판 분류*/
	private String boTitle;                 /*제목*/
	private String boSubCate;               /*글 분류*/
	private int    boHit;                   /*조회수*/
	private String boRegDate;               /*작성일*/
	private String boModDate;               /*수정일*/
	private String boDelYn;                 /*삭제여부*/
	private String boContent;               /*내용*/
	private int    boLike;                  /*추천수*/
	private String boFile;                  /*파일*/
	private String boMemId;                 /*아이디*/
	private String boTeamName;              /*팀이름*/
	private String boWriter;                /*이름*/
	private String boPos;                   /*희망 포지션*/
	
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}

	
	public int getBoNo() {
		return boNo;
	}

	public void setBoNo(int boNo) {
		this.boNo = boNo;
	}

	public String getBoCate() {
		return boCate;
	}

	public void setBoCate(String boCate) {
		this.boCate = boCate;
	}

	public String getBoTitle() {
		return boTitle;
	}

	public void setBoTitle(String boTitle) {
		this.boTitle = boTitle;
	}

	public String getBoSubCate() {
		return boSubCate;
	}

	public void setBoSubCate(String boSubCate) {
		this.boSubCate = boSubCate;
	}

	public int getBoHit() {
		return boHit;
	}

	public void setBoHit(int boHit) {
		this.boHit = boHit;
	}

	public String getBoRegDate() {
		return boRegDate;
	}

	public void setBoRegDate(String boRegDate) {
		this.boRegDate = boRegDate;
	}

	public String getBoModDate() {
		return boModDate;
	}

	public void setBoModDate(String boModDate) {
		this.boModDate = boModDate;
	}

	public String getBoDelYn() {
		return boDelYn;
	}

	public void setBoDelYn(String boDelYn) {
		this.boDelYn = boDelYn;
	}

	public String getBoContent() {
		return boContent;
	}

	public void setBoContent(String boContent) {
		this.boContent = boContent;
	}

	public int getBoLike() {
		return boLike;
	}

	public void setBoLike(int boLike) {
		this.boLike = boLike;
	}

	public String getBoFile() {
		return boFile;
	}

	public void setBoFile(String boFile) {
		this.boFile = boFile;
	}

	public String getBoMemId() {
		return boMemId;
	}

	public void setBoMemId(String boMemId) {
		this.boMemId = boMemId;
	}

	public String getBoTeamName() {
		return boTeamName;
	}

	public void setBoTeamName(String boTeamName) {
		this.boTeamName = boTeamName;
	}

	public String getBoWriter() {
		return boWriter;
	}

	public void setBoWriter(String boWriter) {
		this.boWriter = boWriter;
	}

	public String getBoPos() {
		return boPos;
	}

	public void setBoPos(String boPos) {
		this.boPos = boPos;
	}
	
}