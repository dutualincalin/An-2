package com.poo.labvisitor.task1.document;

public class UrlSegment extends TextSegment {
    private final String url;
    private final String description;

    public UrlSegment(String url, String description) {
        this.url = url;
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public String getDescription() {
        return description;
    }

    @Override
    public String accept(DocumentVisitor v){
        return v.visit(this);
    }
}
