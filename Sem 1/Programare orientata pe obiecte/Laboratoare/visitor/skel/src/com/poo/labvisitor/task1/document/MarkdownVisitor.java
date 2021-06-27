package com.poo.labvisitor.task1.document;

public class MarkdownVisitor implements DocumentVisitor{
    @Override
    public String visit(ItalicTextSegment italicText) {
        return ("_" + italicText.getContent() + "_");
    }

    @Override
    public String visit(PlainTextSegment plainText) {
        return (plainText.getContent());
    }

    @Override
    public String visit(BoldTextSegment boldText) {
        return ("**" + boldText.getContent() + "**");
    }

    @Override
    public String visit(UrlSegment urlSegment) {
        return ("[" + urlSegment.getDescription() + "][" + urlSegment.getUrl() + "]" );
    }
}
