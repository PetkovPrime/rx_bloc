package com.primeholding.rxbloc_generator_plugin.intention_action;

import org.jetbrains.annotations.NotNull;

public class BlocWrapWithFormTextFieldBuilderIntentionAction extends BlocWrapWithIntentionAction {
    public BlocWrapWithFormTextFieldBuilderIntentionAction() {
        super(SnippetType.RxTextFormFieldBuilder);
    }

    /**
     * If this action is applicable, returns the text to be shown in the list of intention actions available.
     */
    @NotNull
    public String getText() {
        return "Wrap with RxTextFormFieldBuilder";
    }
}
