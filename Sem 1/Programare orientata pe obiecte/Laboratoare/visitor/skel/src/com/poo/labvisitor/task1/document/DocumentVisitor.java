package com.poo.labvisitor.task1.document;

public interface DocumentVisitor {
    public String visit(ItalicTextSegment italicText);
    public String visit(PlainTextSegment plainText);
    public String visit(BoldTextSegment boldText);
    public String visit(UrlSegment urlSegment);
}
