select
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
        (select count(DISTINCT user_id) as man_count from z_htn_user_screen_info  where sex=0 AND dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )) B ,
        (select count(DISTINCT user_id) as woman_count from z_htn_user_screen_info where sex=1 AND dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )) C ,
        (select count(DISTINCT user_id) as agemin65_count from z_htn_user_screen_info where age<65 AND dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )) D ,
        (select count(DISTINCT user_id) as agemin75_count from z_htn_user_screen_info where age>=65 and age<75  AND dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )) E ,
        (select count(DISTINCT user_id) as agemax75_count from z_htn_user_screen_info where age>=75 AND dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )) K,
        (select count(DISTINCT zhusi.user_id) as blood_pressure_type_one_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
            where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                        )
            GROUP BY dept_id,user_id) ) as zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=1
            ) F,
        (select  count(DISTINCT zhusi.user_id) as blood_pressure_type_two_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
             where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                              )
            GROUP BY dept_id,user_id) ) as zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=2
            ) L,
        (select count(DISTINCT zhusi.user_id) as blood_pressure_type_three_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
             where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                                )
            GROUP BY dept_id,user_id)  ) zhusi
            inner join z_htn_risk_report zhrr on zhusi.id=zhrr.htn_screen_id
            where zhrr.blood_pressure_type=3
        ) M,
        (select count(DISTINCT zhusi.user_id) as coronary_heart_disease_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
             where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                                )
            GROUP BY dept_id,user_id)) zhusi where zhusi.coronary_heart_disease_flg=1 and start_at>='2016-05-30 00:00:00' and start_at<'2016-06-03 00:00:00'
        ) G,
        (select  count(DISTINCT zhusi.user_id) as intake_salt_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
             where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                                )
            GROUP BY dept_id,user_id) ) zhusi
             where zhusi.intake_salt_flg=1
        ) H,
        (select  count(DISTINCT zhusi.user_id) as hypotensor_count from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
                where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                                )
            GROUP BY dept_id,user_id) ) zhusi where zhusi.hypotensor_flg=1
        ) I,
        (select count(DISTINCT zhusi.user_id) as high_cvd_risk from (select * from z_htn_user_screen_info where id in(
            select max(id) id  from z_htn_user_screen_info
             where dept_id IN (
                            SELECT id FROM z_dept
                            WHERE id not in(select id from z_dept where hosp_id in(select hosp_id from z_report_exclude_hosp where company_id=2))
                                OR id in (select dept_id from z_report_include_dept where company_id=2)
                                )
            GROUP BY dept_id,user_id) ) zhusi  INNER JOIN z_htn_risk_report on
            zhusi.id=z_htn_risk_report.htn_screen_id where z_htn_risk_report.cvd_risk_type=2
        ) J