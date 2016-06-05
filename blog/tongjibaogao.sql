select
            z_hosp.name as hosp_name,
            z_t_dept.name as dept_name,
            (ifnull(B.man_count,0)+ifnull(C.woman_count,0)) as total_count,
            B.man_count,
            C.woman_count,
            D.agemin65_count,
            E.agemin75_count,
            K.agemax75_count,
            F.blood_pressure_type_one_count,
            L.blood_pressure_type_two_count,
            M.blood_pressure_type_three_count,
            G.coronary_heart_disease_count,
            H.intake_salt_count,
            I.hypotensor_count,
            J.high_cvd_risk
         from
        ( select dept_id from z_htn_user_screen_info
        where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
        GROUP BY dept_id ) A
        left join (select dept_id, count(DISTINCT user_id) as man_count from z_htn_user_screen_info  where sex=0 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY dept_id) B on A.dept_id=B.dept_id
        left join (select dept_id, count(DISTINCT user_id) as woman_count from z_htn_user_screen_info where sex=1 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY dept_id) C on A.dept_id=C.dept_id
        left join (select dept_id, count(DISTINCT user_id) as agemin65_count from z_htn_user_screen_info where age<65 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'  GROUP BY dept_id) D on A.dept_id=D.dept_id
        left join (select dept_id, count(DISTINCT user_id) as agemin75_count from z_htn_user_screen_info where age>=65 and age<75 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'  GROUP BY dept_id) E on A.dept_id=E.dept_id
        left join (select dept_id, count(DISTINCT user_id) as agemax75_count from z_htn_user_screen_info where age>=75 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'  GROUP BY dept_id) K on A.dept_id=K.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as blood_pressure_type_one_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') as zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=1 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'  GROUP BY zhusi.dept_id
            ) F on A.dept_id=F.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as blood_pressure_type_two_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') as zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=2  and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY zhusi.dept_id
            ) L on A.dept_id=L.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as blood_pressure_type_three_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' ) zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=3  and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY zhusi.dept_id
            ) M on A.dept_id=M.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as coronary_heart_disease_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') zhusi where zhusi.coronary_heart_disease_flg=1
            and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'  GROUP BY zhusi.dept_id) G on A.dept_id=G.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as intake_salt_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') zhusi where zhusi.intake_salt_flg=1
            and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY dept_id) H on A.dept_id=H.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as hypotensor_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') zhusi where zhusi.hypotensor_flg=1
            and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00' GROUP BY zhusi.dept_id) I on A.dept_id=I.dept_id
        left join (select zhusi.dept_id, count(DISTINCT zhusi.user_id) as high_cvd_risk from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00'
            GROUP BY dept_id,user_id) and  start_at>='2016-05-30 00:00:00' and start_at<'2016-06-04 00:00:00') zhusi  INNER JOIN z_htn_risk_report on
            zhusi.id=z_htn_risk_report.htn_screen_id where z_htn_risk_report.cvd_risk_type=2
        GROUP BY zhusi.dept_id
        ) J on A.dept_id=J.dept_id
        LEFT JOIN
                z_dept ON A.dept_id = z_dept.id
        Left join z_hosp on z_dept.hosp_id=z_hosp.id
        LEFT JOIN
            z_t_dept
        ON
            z_dept.t_dept_id = z_t_dept.id
        WHERE
            A.dept_id IN (
                SELECT id FROM z_dept
                WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                    OR id in (select dept_id from z_report_include_dept where company_id=2)
            )