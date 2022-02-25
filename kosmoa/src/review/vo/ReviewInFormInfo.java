package review.vo;

public class ReviewInFormInfo {
	// 리뷰 작성시 가져가야할 데이터 목록들
	private String kind, title, idnum, miid, img1, content, riv_title ,crid;
	// 코스인지 장소인지, 해당 장소 코스 이름, 해당 장소 코스의 id
	// 리뷰 작성자 , 리뷰 이미지, 리뷰 내용, 리뷰 제목, 글번호
	private int scroe, idx;

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIdnum() {
		return idnum;
	}

	public void setIdnum(String idnum) {
		this.idnum = idnum;
	}

	public String getMiid() {
		return miid;
	}

	public void setMiid(String miid) {
		this.miid = miid;
	}

	public String getImg1() {
		return img1;
	}

	public void setImg1(String img1) {
		this.img1 = img1;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRiv_title() {
		return riv_title;
	}

	public void setRiv_title(String riv_title) {
		this.riv_title = riv_title;
	}

	public int getScroe() {
		return scroe;
	}

	public void setScroe(int scroe) {
		this.scroe = scroe;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getCrid() {
		return crid;
	}

	public void setCrid(String crid) {
		this.crid = crid;
	}
	
	
	
	
	
	
	
	
	

}
