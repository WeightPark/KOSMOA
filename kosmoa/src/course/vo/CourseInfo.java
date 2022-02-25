package course.vo;
import java.util.*;
import place.vo.*;

public class CourseInfo {
	private int ci_idx, ai_idx, ci_like, ci_time, cp_order;		// idx번호, 관리자 번호, 종아요 개수
	private String ci_name, ci_id, ci_kind, ci_date, ci_img, ci_desc, ci_st_id, ci_st_name, ci_sk_id, ci_sk_name, pm_id, ci_isview;
	// 코스이름 아이디, 관리자 등록여부, 등록일, 대표 이미지, 코스 예상 소요시간, 코스 설명, 해당 태그,키워드의 이름과 이이디, 사용자(유저 등록일 경우에만), 공개 여부
	private double ci_score;
	// 코스의 평점
	private String pi_img1, pi_id, pi_name, pi_area, pi_desc;
	private String cp_stime, cp_etime;
	private double pi_la, pi_lo;
	// 코스에 해당하는 이미지 1개, 장소아이디, 장소이름, 해당 장소의 지역
	private ArrayList<PlaceInfo> course_place_list;
	
	
	
	public String getPi_desc() {
		return pi_desc;
	}
	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}
	public int getCi_idx() {
		return ci_idx;
	}
	public void setCi_idx(int ci_idx) {
		this.ci_idx = ci_idx;
	}
	public int getAi_idx() {
		return ai_idx;
	}
	public void setAi_idx(int ai_idx) {
		this.ai_idx = ai_idx;
	}
	public int getCi_like() {
		return ci_like;
	}
	public void setCi_like(int ci_like) {
		this.ci_like = ci_like;
	}
	public String getCi_name() {
		return ci_name;
	}
	public void setCi_name(String ci_name) {
		this.ci_name = ci_name;
	}
	public String getCi_id() {
		return ci_id;
	}
	public void setCi_id(String ci_id) {
		this.ci_id = ci_id;
	}
	public String getCi_kind() {
		return ci_kind;
	}
	public void setCi_kind(String ci_kind) {
		this.ci_kind = ci_kind;
	}
	public String getCi_date() {
		return ci_date;
	}
	public void setCi_date(String ci_date) {
		this.ci_date = ci_date;
	}
	public String getCi_img() {
		return ci_img;
	}
	public void setCi_img(String ci_img) {
		this.ci_img = ci_img;
	}
	public int getCi_time() {
		return ci_time;
	}
	public void setCi_time(int ci_time) {
		this.ci_time = ci_time;
	}
	public String getCi_desc() {
		return ci_desc;
	}
	public void setCi_desc(String ci_desc) {
		this.ci_desc = ci_desc;
	}
	public String getCi_st_id() {
		return ci_st_id;
	}
	public void setCi_st_id(String ci_st_id) {
		this.ci_st_id = ci_st_id;
	}
	public String getCi_st_name() {
		return ci_st_name;
	}
	public void setCi_st_name(String ci_st_name) {
		this.ci_st_name = ci_st_name;
	}
	public String getCi_sk_id() {
		return ci_sk_id;
	}
	public void setCi_sk_id(String ci_sk_id) {
		this.ci_sk_id = ci_sk_id;
	}
	public String getCi_sk_name() {
		return ci_sk_name;
	}
	public void setCi_sk_name(String ci_sk_name) {
		this.ci_sk_name = ci_sk_name;
	}
	public String getPm_id() {
		return pm_id;
	}
	public void setPm_id(String pm_id) {
		this.pm_id = pm_id;
	}
	public String getCi_isview() {
		return ci_isview;
	}
	public void setCi_isview(String ci_isview) {
		this.ci_isview = ci_isview;
	}
	public double getCi_score() {
		return ci_score;
	}
	public void setCi_score(double ci_score) {
		this.ci_score = ci_score;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
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
	public String getPi_area() {
		return pi_area;
	}
	public void setPi_area(String pi_area) {
		this.pi_area = pi_area;
	}
	public int getCp_order() {
		return cp_order;
	}
	public void setCp_order(int cp_order) {
		this.cp_order = cp_order;
	}
	public String getCp_stime() {
		return cp_stime;
	}
	public void setCp_stime(String cp_stime) {
		this.cp_stime = cp_stime;
	}
	public String getCp_etime() {
		return cp_etime;
	}
	public void setCp_etime(String cp_etime) {
		this.cp_etime = cp_etime;
	}
	public double getPi_la() {
		return pi_la;
	}
	public void setPi_la(double pi_la) {
		this.pi_la = pi_la;
	}
	public double getPi_lo() {
		return pi_lo;
	}
	public void setPi_lo(double pi_lo) {
		this.pi_lo = pi_lo;
	}
	public ArrayList<PlaceInfo> getCourse_place_list() {
		return course_place_list;
	}
	public void setCourse_place_list(ArrayList<PlaceInfo> course_place_list) {
		this.course_place_list = course_place_list;
	}
}
