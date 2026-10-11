import streamlit as st
import mysql.connector
import pandas as pd


# =========================
# DATABASE CONNECTION
# =========================

def get_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="MySQLNotYours123",
        database="hospital_db"
    )


# =========================
# QUERY DATABASE
# =========================

def get_data(query):
    conn = get_connection()

    df = pd.read_sql(query, conn)

    conn.close()

    return df


# =========================
# STREAMLIT UI
# =========================

st.set_page_config(
    page_title="Hospital Management System",
    layout="wide"
)

st.title("🏥 Hospital Management System")

st.sidebar.title("Menu")

option = st.sidebar.selectbox(
    "Choose a table",
    [
        "Dashboard",
        "Patients",
        "Staffs",
        "Appointments",
        "Payments",
        "Beds",
        "Departments"
    ]
)


# =========================
# DASHBOARD
# =========================

if option == "Dashboard":

    st.header("Hospital Dashboard")

    col1, col2, col3, col4 = st.columns(4)

    patients = get_data(
        "SELECT COUNT(*) AS count FROM patients"
    )

    staffs = get_data(
        "SELECT COUNT(*) AS count FROM staffs"
    )

    appointments = get_data(
        "SELECT COUNT(*) AS count FROM appointments"
    )

    beds = get_data(
        "SELECT COUNT(*) AS count FROM beds_rooms"
    )

    col1.metric(
        "Patients",
        patients["count"][0]
    )

    col2.metric(
        "Staff",
        staffs["count"][0]
    )

    col3.metric(
        "Appointments",
        appointments["count"][0]
    )

    col4.metric(
        "Beds",
        beds["count"][0]
    )


# =========================
# PATIENTS
# =========================

elif option == "Patients":

    st.header("Patients")

    df = get_data("""
        SELECT
            hn_id,
            firstname,
            lastname,
            email,
            phonenumber,
            personal_id,
            date_of_birth
        FROM patients
    """)

    st.dataframe(
        df,
        use_container_width=True
    )


# =========================
# STAFFS
# =========================

elif option == "Staffs":

    st.header("Staffs")

    df = get_data("""
        SELECT
            staff_id,
            firstname,
            lastname,
            staff_username,
            phonenumber,
            role,
            medical_license_no
        FROM staffs
    """)

    st.dataframe(
        df,
        use_container_width=True
    )


# =========================
# APPOINTMENTS
# =========================

elif option == "Appointments":

    st.header("Appointments")

    df = get_data("""
        SELECT
            a.appointment_id,
            CONCAT(p.firstname, ' ', p.lastname) AS patient,
            CONCAT(s.firstname, ' ', s.lastname) AS staff,
            a.appointment_datetime,
            a.status
        FROM appointments a

        JOIN patients p
            ON a.hn_id = p.hn_id

        JOIN staffs s
            ON a.staff_id = s.staff_id
    """)

    st.dataframe(
        df,
        use_container_width=True
    )


# =========================
# PAYMENTS
# =========================

elif option == "Payments":

    st.header("Payments")

    df = get_data("""
        SELECT
            payment_id,
            appointment_id,
            amount,
            payment_datetime,
            payment_method,
            billing_status
        FROM payments
    """)

    st.dataframe(
        df,
        use_container_width=True
    )


# =========================
# BEDS
# =========================

elif option == "Beds":

    st.header("Beds")

    df = get_data("""
        SELECT
            b.bed_id,
            b.bed_number,
            w.ward_name,
            rt.type_name AS room_type,
            rt.daily_rate,
            b.status
        FROM beds_rooms b

        JOIN wards w
            ON b.ward_id = w.ward_id

        JOIN room_type rt
            ON b.room_type_id = rt.room_type_id
    """)

    st.dataframe(
        df,
        use_container_width=True
    )


# =========================
# DEPARTMENTS
# =========================

elif option == "Departments":

    st.header("Departments")

    df = get_data("""
        SELECT
            d.department_id,
            d.department_name,
            b.building_name,
            d.phone_extension
        FROM departments d

        JOIN buildings b
            ON d.building_id = b.building_id
    """)

    st.dataframe(
        df,
        use_container_width=True
    )