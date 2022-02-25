package customer.vo;

public class AnswerInfo {
// 하나의 QnA 답변을 저장할 클래스(모든 답변을 한 곳에서 처리)
	private int a_idx, q_idx, ai_idx;
	private String oi_id, a_answer, a_date, q_issecret;
	
	public int getA_idx() {
		return a_idx;
	}
	public void setA_idx(int a_idx) {
		this.a_idx = a_idx;
	}
	public int getQ_idx() {
		return q_idx;
	}
	public void setQ_idx(int q_idx) {
		this.q_idx = q_idx;
	}
	public int getAi_idx() {
		return ai_idx;
	}
	public void setAi_idx(int ai_idx) {
		this.ai_idx = ai_idx;
	}
	public String getOi_id() {
		return oi_id;
	}
	public void setOi_id(String oi_id) {
		this.oi_id = oi_id;
	}
	public String getA_answer() {
		return a_answer;
	}
	public void setA_answer(String a_answer) {
		this.a_answer = a_answer;
	}
	public String getA_date() {
		return a_date;
	}
	public void setA_date(String a_date) {
		this.a_date = a_date;
	}
	public String getQ_issecret() {
		return q_issecret;
	}
	public void setQ_issecret(String q_issecret) {
		this.q_issecret = q_issecret;
	}
}
