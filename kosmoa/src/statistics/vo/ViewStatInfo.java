package statistics.vo;

public class ViewStatInfo {
// 장소 코스 예약 및 조회수에 대한 정보들을 저장할 인스턴스
	private String ci_id, ci_name;
	private int sum_reserve, sum_sch, sum_save;
	
	public String getCi_id() {
		return ci_id;
	}
	public void setCi_id(String ci_id) {
		this.ci_id = ci_id;
	}
	public String getCi_name() {
		return ci_name;
	}
	public void setCi_name(String ci_name) {
		this.ci_name = ci_name;
	}
	public int getSum_reserve() {
		return sum_reserve;
	}
	public void setSum_reserve(int sum_reserve) {
		this.sum_reserve = sum_reserve;
	}
	public int getSum_sch() {
		return sum_sch;
	}
	public void setSum_sch(int sum_sch) {
		this.sum_sch = sum_sch;
	}
	public int getSum_save() {
		return sum_save;
	}
	public void setSum_save(int sum_save) {
		this.sum_save = sum_save;
	}
	
	
	
	
}
