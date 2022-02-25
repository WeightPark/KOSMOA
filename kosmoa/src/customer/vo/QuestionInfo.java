package customer.vo;

public class QuestionInfo {
// 하나의 QnA 질문을 저장할 클래스(모든 질문을 한 곳에서 처리)
	private int q_idx;
	private String pm_id, oi_id, q_cata, q_question, q_content, q_file, q_issecret, q_date, q_isanswer, q_isview;
	public int getQ_idx() {
		return q_idx;
	}
	public void setQ_idx(int q_idx) {
		this.q_idx = q_idx;
	}
	public String getPm_id() {
		return pm_id;
	}
	public void setPm_id(String pm_id) {
		this.pm_id = pm_id;
	}
	public String getOi_id() {
		return oi_id;
	}
	public void setOi_id(String oi_id) {
		this.oi_id = oi_id;
	}
	public String getQ_cata() {
		return q_cata;
	}
	public void setQ_cata(String q_cata) {
		this.q_cata = q_cata;
	}
	public String getQ_question() {
		return q_question;
	}
	public void setQ_question(String q_question) {
		this.q_question = q_question;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getQ_file() {
		return q_file;
	}
	public void setQ_file(String q_file) {
		this.q_file = q_file;
	}
	public String getQ_issecret() {
		return q_issecret;
	}
	public void setQ_issecret(String q_issecret) {
		this.q_issecret = q_issecret;
	}
	public String getQ_date() {
		return q_date;
	}
	public void setQ_date(String q_date) {
		this.q_date = q_date;
	}
	public String getQ_isanswer() {
		return q_isanswer;
	}
	public void setQ_isanswer(String q_isanswer) {
		this.q_isanswer = q_isanswer;
	}
	public String getQ_isview() {
		return q_isview;
	}
	public void setQ_isview(String q_isview) {
		this.q_isview = q_isview;
	}
	
	
}
