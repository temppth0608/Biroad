package comment;

public class Comment {

	private int commentId;
	private String boardId;
	private String commentMemb;
	private String text;
	
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getCommentMemb() {
		return commentMemb;
	}
	public void setCommentMemb(String commentMemb) {
		this.commentMemb = commentMemb;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
}
