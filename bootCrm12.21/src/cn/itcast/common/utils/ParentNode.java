package cn.itcast.common.utils;

import java.util.ArrayList;

import org.apache.poi.poifs.property.Child;

public class ParentNode {//第一级
	private String text;
	private ArrayList<ChildNode> nodes;
	
	
	public ParentNode(String text, ArrayList<ChildNode> nodes) {
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
	public ArrayList<ChildNode> getNodes() {
		return nodes;
	}
	public void setNodes(ArrayList<ChildNode> nodes) {
		this.nodes = nodes;
	}

	@Override
	public String toString() {
		return "ParentNode [text=" + text + ", nodes=" + nodes + "]";
	}
	
	
}
