package review.vo;

public class CreviewPageInfo {
	// �ڽ� ���� ����¡ ����
	private int cpage, psize, bsize, spage, epage, rcnt, pcnt;
	// ���� ��������ȣ, ������ũ��, ��� ũ��, ����������, ����������, �Խù� ��, ������ ��  
	private String keyword, kind;
	
	public int getCpage() {
		return cpage;
	}
	public void setCpage(int cpage) {
		this.cpage = cpage;
	}
	public int getPsize() {
		return psize;
	}
	public void setPsize(int psize) {
		this.psize = psize;
	}
	public int getBsize() {
		return bsize;
	}
	public void setBsize(int bsize) {
		this.bsize = bsize;
	}
	public int getSpage() {
		return spage;
	}
	public void setSpage(int spage) {
		this.spage = spage;
	}
	public int getEpage() {
		return epage;
	}
	public void setEpage(int epage) {
		this.epage = epage;
	}
	public int getRcnt() {
		return rcnt;
	}
	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	public int getPcnt() {
		return pcnt;
	}
	public void setPcnt(int pcnt) {
		this.pcnt = pcnt;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	
	
}
