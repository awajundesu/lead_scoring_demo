WITH rand AS(
  SELECT
    *,
    case
      when rand() > 0.9 then 'UNK'
      else job_title
    end as job_title2
  FROM lead_scoring
)

INSERT OVERWRITE TABLE lead_scoring2
SELECT
  rowid() as rowid,
  converted,
  days_since_signup,
  completed_form,
  visited_pricing,
  registered_for_webinar,
  attended_webinar,
  case
    when LOWER(job_title2) LIKE '%manager%' then 1
    when LOWER(job_title2) LIKE '%director%' then 1
    when LOWER(job_title2) LIKE '%supervisor%' then 1
    else 0
  end as is_manager,
  case
    when acquisition_channel = 'Cold Call' then 1
    else 0
  end as acquisition_channel_Cold_Call,
  case
    when acquisition_channel = 'Cold Email' then 1
    else 0
  end as acquisition_channel_cold_email,
  case
    when acquisition_channel = 'Paid Leads' then 1
    else 0
  end as acquisition_channel_paid_leads,
  case
    when acquisition_channel = 'Organic Search' then 1
    else 0
  end as acquisition_channel_organic_search,
  case
    when company_size = '11-50' then 1
    else 0
  end as company_size_11_50,
  case
    when company_size = '51-100' then 1
    else 0
  end as company_size_51_100,
  case
    when company_size = '101-250' then 1
    else 0
  end as company_size_101_250,
  case
    when company_size = '251-1000' then 1
    else 0
  end as company_size_251_1000,
  case
    when company_size = '1000-10000' then 1
    else 0
  end as company_size_1000_10000,
  case
    when company_size = '10001+' then 1
    else 0
  end as company_size_10001,
  case
    when industry = 'Financial Services' then 1
    else 0
  end as industry_financial_services,
  case
    when industry = 'Scandanavion Design' then 1
    else 0
  end as industry_scandanavion_design,
  case
    when industry = 'Web & Internet' then 1
    else 0
  end as industry_web_internet,
  case
    when industry = 'Furniture' then 1
    else 0
  end as industry_furniture,
  case
    when industry = 'Heavy Manufacturing' then 1
    else 0
  end as industry_heavy_manufacturing
FROM rand

