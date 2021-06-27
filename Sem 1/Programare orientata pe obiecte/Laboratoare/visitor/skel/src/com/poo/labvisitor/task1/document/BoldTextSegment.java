package com.poo.labvisitor.task1.document;

public class BoldTextSegment extends TextSegment {
    public BoldTextSegment(String content) {
        super(content);
    }

    @Override
    public String accept(DocumentVisitor v){
        return v.visit(this);
    }
}
