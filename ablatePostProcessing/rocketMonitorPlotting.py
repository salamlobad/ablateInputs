import csv
with open('testLog.csv') as file:

    reader = csv.reader(file)
    for row in reader:
        print(row)

        #"\\wsl.localhost\Ubuntu\home\salaml\ablateInputs\peregrineMotor.2D.V01\_2dPeregrineMotorTest_2022-07-12T13-31-15\testLog.csv"