import mysql.connector
import matplotlib.pyplot as plt
import pandas as pd

# Kết nối đến cơ sở dữ liệu
def connect_to_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",       
        password="123456",  
        database="bai_tap_lon"  
    )

# Truy vấn dữ liệu từ cơ sở dữ liệu
def query_data(query, params=None):
    connection = connect_to_db()
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query, params or {})
    results = cursor.fetchall()
    connection.close()
    return pd.DataFrame(results)

# Hiển thị biểu đồ
def plot_chart(chart_type, data, x_col, y_col, title, x_label, y_label):
    if chart_type == "bar":
        plt.bar(data[x_col], data[y_col])
    elif chart_type == "pie":
        plt.pie(data[y_col], labels=data[x_col], autopct='%1.1f%%', startangle=90)
    elif chart_type == "line":
        plt.plot(data[x_col], data[y_col], marker='o')
    elif chart_type == "radar":
        categories = list(data[x_col])
        values = data[y_col].values
        values = list(values) + [values[0]]  # Đóng vòng radar
        angles = [n / float(len(categories)) * 2 * 3.14159 for n in range(len(categories))]
        angles += angles[:1]
        plt.polar(angles, values)
        plt.fill(angles, values, alpha=0.4)
        plt.xticks(angles[:-1], categories)
    plt.title(title)
    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.show()

# 1. Biểu đồ cột: Phân bố nhân sự theo phòng ban
def plot_department_distribution():
    query = """
        SELECT department_name, COUNT(*) AS total_employees
        FROM Employees
        JOIN Departments ON Employees.department_id = Departments.department_id
        GROUP BY department_name
    """
    data = query_data(query)
    plot_chart("bar", data, "department_name", "total_employees", 
               "Phân bố nhân sự theo phòng ban", "Phòng ban", "Số nhân viên")

# 2. Biểu đồ tròn: Phân tích độ tuổi nhân viên
def plot_age_analysis():
    query = """
        SELECT CASE
                   WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 30 THEN 'Dưới 30'
                   WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 30 AND 40 THEN '30-40'
                   ELSE 'Trên 40' END AS age_group,
               COUNT(*) AS total_employees
        FROM Employees
        GROUP BY age_group
    """
    data = query_data(query)
    plot_chart("pie", data, "age_group", "total_employees", 
               "Phân tích độ tuổi nhân viên", "", "")

# 3. Biểu đồ radar: Đánh giá hiệu suất nhân viên
def plot_performance_evaluation():
    query = """
        SELECT CONCAT(first_name, ' ', last_name) AS employee_name, AVG(performance_score) AS avg_score
        FROM Performance
        JOIN Employees ON Performance.employee_id = Employees.employee_id
        GROUP BY employee_name
        LIMIT 5
    """
    data = query_data(query)
    plot_chart("radar", data, "employee_name", "avg_score", 
               "Đánh giá hiệu suất nhân viên", "", "Điểm trung bình")

# 4. Biểu đồ đường: Hiệu quả chương trình đào tạo
def plot_training_effectiveness():
    query = """
        SELECT training_name, AVG(training_outcome) AS avg_outcome
        FROM Training
        GROUP BY training_name
    """
    data = query_data(query)
    plot_chart("line", data, "training_name", "avg_outcome", 
               "Hiệu quả chương trình đào tạo", "Chương trình đào tạo", "Kết quả trung bình")

# 5. Biểu đồ cột: Thâm niên của nhân viên
def plot_employee_tenure():
    query = """
        SELECT CASE
                   WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 5 THEN 'Dưới 5 năm'
                   WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) BETWEEN 5 AND 10 THEN '5-10 năm'
                   ELSE 'Trên 10 năm' END AS tenure_group,
               COUNT(*) AS total_employees
        FROM Employees
        GROUP BY tenure_group
    """
    data = query_data(query)
    plot_chart("bar", data, "tenure_group", "total_employees", 
               "Thâm niên của nhân viên", "Thâm niên", "Số nhân viên")

# Giao diện nhập tham số từ bàn phím
def main():
    print("Chọn loại biểu đồ muốn vẽ:")
    print("1. Phân bố nhân sự theo phòng ban")
    print("2. Phân tích độ tuổi nhân viên")
    print("3. Đánh giá hiệu suất nhân viên")
    print("4. Hiệu quả chương trình đào tạo")
    print("5. Thâm niên của nhân viên")
    choice = int(input("Nhập lựa chọn (1-5): "))
    
    if choice == 1:
        plot_department_distribution()
    elif choice == 2:
        plot_age_analysis()
    elif choice == 3:
        plot_performance_evaluation()
    elif choice == 4:
        plot_training_effectiveness()
    elif choice == 5:
        plot_employee_tenure()
    else:
        print("Lựa chọn không hợp lệ!")

if __name__ == "__main__":
    main()
