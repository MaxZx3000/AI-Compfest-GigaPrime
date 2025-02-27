from nltk import treebank

class PrettyPrint():
    def pretty_print_tokenized_document(self, sentences):
        detokenizer = treebank.TreebankWordDetokenizer()
        detokenized_document = detokenizer.detokenize(sentences)
        return detokenized_document