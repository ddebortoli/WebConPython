from flask import Flask,render_template,request,redirect,url_for,flash
from flask_mysqldb import MySQL
from datetime import datetime

app = Flask(__name__)

#MySql connection
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'speedmaxdb'
mysql = MySQL(app)

# settings
app.secret_key = 'mysecretkey'

@app.route('/')
def home():
    return render_template('home.html')

#Main window
@app.route('/invoice')
def invoice():
    cur = mysql.connection.cursor()
    cur.execute('CALL `getDataFromClient`(0);')
    data = cur.fetchall()
    cur.execute('CALL `getLocations`();')
    locationsData = cur.fetchall()
    cur.execute('CALL `getPackages`();')
    packagesData = cur.fetchall()
    cur.execute('CALL `getPaymentMethods`();')
    paymentMethods = cur.fetchall()
    
    return render_template('invoice.html',clients = data,locations = locationsData,packages = packagesData,payments = paymentMethods)

    
@app.route('/invoice/edit/<id>', methods = ['POST', 'GET'])
def get_contact(id):
    cur = mysql.connection.cursor()
    cur.execute('CALL `getPersonalData`({0});'.format(id))
    data = cur.fetchall()
    cur.execute('CALL `getLocations`();')
    locationsData = cur.fetchall()
    cur.execute('CALL `getPackages`();')
    packagesData = cur.fetchall()
    cur.execute('CALL `getPaymentMethods`();')
    paymentMethods = cur.fetchall()
    print(data)
    cur.close()
    return render_template('edit-contact.html', client = data[0],locations = locationsData,packages = packagesData,payments = paymentMethods)

@app.route('/invoice/update/<id>', methods=['POST'])
def update_contact(id):
    if request.method == 'POST':
        re = request.form.to_dict()
        fullname = re['fullname']
        phone = re['phone']
        email = re['email']
        adress = re['adress']
        location = re['location']
        package = re['package']
        payment = re['paymentId']
        if missingMandatoryParameters(re):
                return redirect(url_for('invoice'))
        cur = mysql.connection.cursor()
        cur.execute("""
            UPDATE datos_cliente SET `fullname`=%s,`phone`=%s,`email`=%s,`adress`=%s,
            `location`=%s,`packageId`=%s,`paymentMethodId`=%s WHERE Id = %s
        """, (fullname, phone, email,adress,location,package,payment, id))
        mysql.connection.commit()
        flash('Contact Updated Successfully')
        return redirect(url_for('invoice'))
def missingMandatoryParameters(Parameters):
    error = False
    for name,parameter in Parameters.items():
        if(len(parameter) < 1):
            flash('Error - Mandatory parameter Missing: '+ name.capitalize())
            error = True
    return error

def getClientIdByAdress(adress):
    cur = mysql.connection.cursor()
    cur.execute("CALL `getIdFromClient`('{}');".format(adress))
    currentId = cur.fetchone()
    if currentId != None:
        return currentId[0]
    return None
                       
#Create Contact    
@app.route('/invoice/add', methods = ['POST'])
def invoice_add():
    if request.method == 'POST':
        re = request.form.to_dict()
        fullname = re['fullname']
        phone = re['phone']
        email = re['email']
        adress = re['adress']
        location = re['location']
        package = re['package']
        payment = re['paymentId']
        if missingMandatoryParameters(re):
            return redirect(url_for('invoice'))

        cur = mysql.connection.cursor()
        #Inserto el nuevo cliente a la base de datos
        cur.execute('INSERT INTO datos_cliente (fullname,phone,email,adress,location,packageId,paymentMethodId)VALUES(%s,%s,%s,%s,%s,%s,%s)',(fullname,phone,email,adress,location,package,payment))
        mysql.connection.commit()
        #Obtengo su ID
        userId = getClientIdByAdress(adress)
        if userId:
            currentTime = datetime.now().strftime("%Y-%m-%d")
            cur.execute('INSERT INTO invoicestatus (`ID`, `creationDate`, `latePayment`, `lastPayment`, `isOnline`)VALUES(%s,%s,%s,%s,%s)',(userId,currentTime,0,currentTime,True))
            
        
        flash('Contact added sucessfully')
        return redirect(url_for('invoice'))

#Delete contact        
@app.route('/invoice/delete/<string:id>')
def invoice_delete(id):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM datos_cliente WHERE id = {0}'.format(id))
    mysql.connection.commit()
    flash('Sucessfully deleted')
    return redirect(url_for('invoice'))


if __name__ == '__main__':
    app.run(port = 3000,debug=True)