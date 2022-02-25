package customer.vo;

public class FaqInfo {
// 하나의 FAQ 내용을 저장할 클래스 
	private int fl_idx, ai_idx;
	private String fl_question, fl_answer, fl_date;
	
	public int getFl_idx() {
		return fl_idx;
	}
	public void setFl_idx(int fl_idx) {
		this.fl_idx = fl_idx;
	}
	public int getAi_idx() {
		return ai_idx;
	}
	public void setAi_idx(int ai_idx) {
		this.ai_idx = ai_idx;
	}
	public String getFl_question() {
		return fl_question;
	}
	public void setFl_question(String fl_question) {
		this.fl_question = fl_question;
	}
	public String getFl_answer() {
		return fl_answer;
	}
	public void setFl_answer(String fl_answer) {
		this.fl_answer = fl_answer;
	}
	public String getFl_date() {
		return fl_date;
	}
	public void setFl_date(String fl_date) {
		this.fl_date = fl_date;
	}
	
}
