package com.poo.labvisitor.task1.document;

public class DokuWikiVisitor implements DocumentVisitor {
    @Override
    public String visit(ItalicTextSegment italicText) {

        return ("//" + italicText.getContent() + "//");
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
        return ("[[" + urlSegment.getUrl() + "|" + urlSegment.getDescription() + "]]");
    }
}