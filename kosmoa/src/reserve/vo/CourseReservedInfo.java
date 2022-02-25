package reserve.vo;

// 코스 예약 정보를 담을 CourseReservedInfo 클래스 
public class CourseReservedInfo {
	private int cr_person;
	private String cr_id, ci_id, ci_name, pm_id, cr_rdate, cr_date, cr_status;
	
	public int getCr_person() {
		return cr_person;
	}
	public void setCr_person(int cr_person) {
		this.cr_person = cr_person;
	}
	public String getCr_id() {
		return cr_id;
	}
	public void setCr_id(String cr_id) {
		this.cr_id = cr_id;
	}
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
	public String getPm_id() {
		return pm_id;
	}
	public void setPm_id(String pm_id) {
		this.pm_id = pm_id;
	}
	public String getCr_rdate() {
		return cr_rdate;
	}
	public void setCr_rdate(String cr_rdate) {
		this.cr_rdate = cr_rdate;
	}
	public String getCr_date() {
		return cr_date;
	}
	public void setCr_date(String cr_date) {
		this.cr_date = cr_date;
	}
	public String getCr_status() {
		return cr_status;
	}
	public void setCr_status(String cr_status) {
		this.cr_status = cr_status;
	}
}
