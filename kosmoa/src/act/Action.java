package act;
import javax.servlet.http.*;
import vo.*;


public interface Action {
// ���� ��û�� ���� ó���� ������ ������� ó���ǰ� �� implements��ų �������̽�
	ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception;
	// �� ��û�� ó���ϴ� ActionŬ�������� ���������� �����ؾ� �ϴ� �޼ҵ�μ� ����� �޼ҵ� , �������̽����� ������ �޼ҵ���� �⺻������ public abstract
}
