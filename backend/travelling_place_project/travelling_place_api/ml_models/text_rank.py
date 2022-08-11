import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

class TextRank():
  def _get_text_rank_matrix(self, sentence_tokenized, alpha = 0.3):
    tf_idf_vectorizer = TfidfVectorizer(norm = 'l1')
    
    tf_idf_matrix = tf_idf_vectorizer.fit_transform(sentence_tokenized)

    cosine_similarity_matrix = cosine_similarity(
        tf_idf_matrix
    )

    sum_all_rows = cosine_similarity_matrix.sum(axis = 1, dtype = 'float64')
    normalized_cosine_similarity_matrix = cosine_similarity_matrix / sum_all_rows.reshape(-1, 1)
    number_of_sentences = normalized_cosine_similarity_matrix.shape[0]
    uniform_matrix = np.full(fill_value = 1 / number_of_sentences, shape = (number_of_sentences, number_of_sentences))
    text_rank_matrix = alpha * uniform_matrix + (1 - alpha) * normalized_cosine_similarity_matrix

    # For debugging purpose.
    if np.isnan(text_rank_matrix).any():
      # print(type(text_rank_matrix.todense()))
      for sentence in sentence_tokenized:
        print(f"'{sentence}'")
      for vector in text_rank_matrix:
        print(vector)

    return text_rank_matrix

  def _get_scores(self, text_rank_matrix):
    eigenvalues, normalized_eigenvectors = np.linalg.eig(text_rank_matrix.T)
    valid_index = self._get_index_from_specified_value(eigenvalues, 1.)[0]
    scores = normalized_eigenvectors[:, valid_index]
    scores = normalized_eigenvectors[:, valid_index] / normalized_eigenvectors[:, valid_index].sum()
    return scores

  def _get_index_from_specified_value(self, my_array, find_value):
    equivalent_indexes = []
    for index, value in enumerate(my_array):
        if np.isclose(value, find_value):
            equivalent_indexes.append(index)

    return equivalent_indexes

  def _get_summarized_text(self, sentences, scores, max_largest_index):
    if len(scores) - 1 < max_largest_index:
      return sentences
    
    summarized_texts = []
    threshold = sorted(scores, reverse = True)[max_largest_index - 1]

    for sentence, score in zip(sentences, scores):
      if score >= threshold:
        summarized_texts.append(sentence)

    return summarized_texts

  def summarize_text(self, sentence_tokenized, max_largest_index = 5, alpha = 0.15):
    # Remove any words with less than given length of sentences.
    # sentence_tokenized = preprocess_text(sentences, word_length_threshold)

    # print(sentence_tokenized)
  
    text_rank_matrix = self._get_text_rank_matrix(sentence_tokenized, alpha)
    scores = self._get_scores(text_rank_matrix)

    summarized_text = self._get_summarized_text(sentence_tokenized, scores, max_largest_index)

    return summarized_text