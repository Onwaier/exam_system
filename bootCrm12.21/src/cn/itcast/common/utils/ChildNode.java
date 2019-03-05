package cn.itcast.common.utils;

import java.util.ArrayList;

public class ChildNode {//第二级
	private String text;
	private ArrayList<GrandsonNode> nodes;
	
	public ChildNode(String text, ArrayList<GrandsonNode> nodes) {
		super();
		this.text = text;
		this.nodes = nodes;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public ArrayList<GrandsonNode> getNodes() {
		return nodes;
	}

	public void setNodes(ArrayList<GrandsonNode> nodes) {
		this.nodes = nodes;
	}

	@Override
	public String toString() {
		return "ChildNode [text=" + text + ", nodes=" + nodes + "]";
	}
	
	
	
}
