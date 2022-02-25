package reserve.vo;

// 장소 예약 정보를 담을 PlaceReservedInfo 클래스 
public class PlaceReservedInfo {
	private int pr_person;
	private String pr_id, pi_id, pi_name, pm_id, pr_rdate, pr_date, pr_status;
	
	public int getPr_person() {
		return pr_person;
	}
	public void setPr_person(int pr_person) {
		this.pr_person = pr_person;
	}
	public String getPr_id() {
		return pr_id;
	}
	public void setPr_id(String pr_id) {
		this.pr_id = pr_id;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getPm_id() {
		return pm_id;
	}
	public void setPm_id(String pm_id) {
		this.pm_id = pm_id;
	}
	public String getPr_rdate() {
		return pr_rdate;
	}
	public void setPr_rdate(String pr_rdate) {
		this.pr_rdate = pr_rdate;
	}
	public String getPr_date() {
		return pr_date;
	}
	public void setPr_date(String pr_date) {
		this.pr_date = pr_date;
	}
	public String getPr_status() {
		return pr_status;
	}
	public void setPr_status(String pr_status) {
		this.pr_status = pr_status;
	}	
}
