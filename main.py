from unittest2 import result
from flask import Flask , render_template , request
import numpy as np
import pickle4 as pickle

model=pickle.load(open('titanic_model_lr_Sa1','rb'))

app=Flask(__name__)

@app.route ('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])

def predict_survival():
    pclass=int(request.form.get('pclass'))
    sex=int(request.form.get('sex'))
    age=int(request.form.get('age'))
    fare=int(request.form.get('fare'))
    
    result = model.predict(np.array([pclass,sex,age,fare]).reshape(1,4))
    
    if result==1:
        result="Alive"
    elif result==0:
        result="Dead"
        
    return str(result)
    

    
    
if __name__=='__main__':
    app.run(debug=True)
