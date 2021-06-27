package com.poo.labvisitor.task1;

import com.poo.labvisitor.task1.document.DocumentVisitor;
import com.poo.labvisitor.task1.document.DokuWikiVisitor;
import com.poo.labvisitor.task1.document.MarkdownVisitor;
import com.poo.labvisitor.task1.document.TextSegment;

import java.util.List;

/**
 * Uses visitors to parse documents and provide dokuwiki and markdown outputs.
 */
public class WikiGenerator {

    private final List<TextSegment> textSegments;

    public WikiGenerator(List<TextSegment> textSegments) {
        this.textSegments = textSegments;
    }

    public StringBuilder getDokuWikiDocument() {
        StringBuilder helper = new StringBuilder();
        DocumentVisitor v = new DokuWikiVisitor();
        for(TextSegment t: textSegments){
            helper.append(t.accept(v));
        }
        return helper;
    }

    public StringBuilder getMarkdownDocument() {
        StringBuilder helper = new StringBuilder();
        DocumentVisitor v = new MarkdownVisitor();
        for(TextSegment t: textSegments){
            helper.append(t.accept(v));
        }

        return helper;
    }
}
