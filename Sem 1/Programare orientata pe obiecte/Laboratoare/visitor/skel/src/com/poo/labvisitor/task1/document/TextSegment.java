package com.poo.labvisitor.task1.document;

/**
 * Represents a text segment of a document that needs to be parsed.
 */
public abstract class TextSegment {
    private String content;

    TextSegment(String content) {
        this.content = content;
    }

    protected TextSegment() {
    }

    public String getContent() {
        return content;
    }

    public abstract String accept(DocumentVisitor v);

    // Partea a 2-a consta in inlocuirea metodei abstracte "accept" cu metoda "accept" comentata
    // si comentarea metodelor "accept" din subclasele acestei clase ca sa nu suprascrie metoda.

//    public String accept(DocumentVisitor v){
//        if(this instanceof BoldTextSegment)
//            return v.visit((BoldTextSegment) this);
//
//        if(this instanceof ItalicTextSegment)
//            return v.visit((ItalicTextSegment) this);
//
//        if(this instanceof PlainTextSegment)
//            return v.visit((PlainTextSegment) this);
//
//        return v.visit((UrlSegment) this);
//    }
}
