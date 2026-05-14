from flask import Flask, request, jsonify
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

def get_best_match(donation_desc, donation_category, donation_location, charities_data):
    try:
        df = pd.DataFrame(charities_data)
        if df.empty:
            return None

        # 1. مطابقة الاحتياجات والفئة (Text Similarity) باستخدام TF-IDF
        # دمج احتياجات الجمعية مع فئتها لتكوين نص واحد للمقارنة
        df['combined_features'] = df.get('needs', '') + " " + df.get('category', '')
        donation_text = f"{donation_desc} {donation_category}"
        
        all_texts = df['combined_features'].tolist() + [donation_text]
        vectorizer = TfidfVectorizer()
        tfidf_matrix = vectorizer.fit_transform(all_texts)
        
        # حساب نسبة تطابق النصوص (من 0 إلى 1)
        text_scores = cosine_similarity(tfidf_matrix[-1], tfidf_matrix[:-1])[0]
        df['text_score'] = text_scores

        # 2. مطابقة الموقع الجغرافي (Location Match)
        # إذا كان الموقع متطابقاً تأخذ الجمعية 1، وإلا 0
        df['location_score'] = (df.get('location', '').str.lower() == donation_location.lower()).astype(float)

        # 3. تقييم الجمعية (Rating Score)
        # تحويل التقييم من (0-5) إلى نسبة مئوية (0-1)
        df['rating_score'] = df.get('rating', 0).astype(float) / 5.0

        # حساب النتيجة النهائية بناءً على أوزان محددة
        # (مثلاً: 50% للاحتياج، 30% للموقع، 20% للتقييم)
        df['final_score'] = (df['text_score'] * 0.5) + (df['location_score'] * 0.3) + (df['rating_score'] * 0.2)

        best_match_idx = df['final_score'].idxmax()
        best_score = df.iloc[best_match_idx]['final_score']

        # إذا كانت النتيجة الإجمالية أعلى من حد معين، نعتبرها مطابقة ناجحة
        if best_score > 0.2: 
            return {
                'charity_id': int(df.iloc[best_match_idx]['charity_id']),
                'score': round(float(best_score), 4),
                'details': {
                    'text_score': round(float(df.iloc[best_match_idx]['text_score']), 4),
                    'location_match': bool(df.iloc[best_match_idx]['location_score']),
                    'rating': float(df.iloc[best_match_idx]['rating'])
                }
            }
        return None
    except Exception as e:
        logging.error(f"Error in matching logic: {e}")
        return None

@app.route('/match', methods=['POST'])
def match_donation():
    data = request.get_json()
    
    if not data:
        return jsonify({"error": "Invalid JSON"}), 400

    donation_desc = data.get('description', '')
    donation_category = data.get('category', '')
    donation_location = data.get('location', '') # إضافة الموقع الخاص بالتبرع
    charities = data.get('charities', []) 

    if not charities:
        return jsonify({"error": "No charities provided for matching"}), 400

    best_match = get_best_match(donation_desc, donation_category, donation_location, charities)

    if not best_match:
         return jsonify({"message": "No strong match found", "match": None}), 404

    return jsonify({
        "message": "Match successful", 
        "match": best_match
    })

if __name__ == '__main__':
    # يعمل على المنفذ 5000
    app.run(port=5000, host='0.0.0.0', debug=True)