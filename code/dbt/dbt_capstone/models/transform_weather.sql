with transformed_weather as (
    select 
        time,
        temperature_2m,
        relative_humidity_2m,
        precipitation,
        cloud_cover,
        case when
            cloud_cover_low BETWEEN 0 AND 25 THEN 'Clear'
            when cloud_cover_low BETWEEN 26 AND 50 THEN 'Partly Cloudy'
            when cloud_cover_low BETWEEN 51 AND 75 THEN 'Mostly Cloudy'
            when cloud_cover_low BETWEEN 76 AND 100 THEN 'Overcast'
        end as cloud_cover_low,
        case when
            cloud_cover_mid BETWEEN 0 AND 25 THEN 'Clear'
            when cloud_cover_mid BETWEEN 26 AND 50 THEN 'Partly Cloudy'
            when cloud_cover_mid BETWEEN 51 AND 75 THEN 'Mostly Cloudy'
            when cloud_cover_mid BETWEEN 76 AND 100 THEN 'Overcast'
        end as cloud_cover_mid,
        case when
            cloud_cover_high BETWEEN 0 AND 25 THEN 'Clear'
            when cloud_cover_high BETWEEN 26 AND 50 THEN 'Partly Cloudy'
            when cloud_cover_high BETWEEN 51 AND 75 THEN 'Mostly Cloudy'
            when cloud_cover_high BETWEEN 76 AND 100 THEN 'Overcast'
        end as cloud_cover_high,
        wind_speed_10m,
        wind_direction_10m,
        case 
            when wind_direction_10m BETWEEN 348.75 AND 360 OR wind_direction_10m BETWEEN 0 AND 11.25 THEN 'N'
            WHEN wind_direction_10m BETWEEN 11.25 AND 33.75 THEN 'NNE'
            WHEN wind_direction_10m BETWEEN 33.75 AND 56.25 THEN 'NE'
            WHEN wind_direction_10m BETWEEN 56.25 AND 78.75 THEN 'ENE'
            WHEN wind_direction_10m BETWEEN 78.75 AND 101.25 THEN 'E'
            WHEN wind_direction_10m BETWEEN 101.25 AND 123.75 THEN 'ESE'
            WHEN wind_direction_10m BETWEEN 123.75 AND 146.25 THEN 'SE'
            WHEN wind_direction_10m BETWEEN 146.25 AND 168.75 THEN 'SSE'
            WHEN wind_direction_10m BETWEEN 168.75 AND 191.25 THEN 'S'
            WHEN wind_direction_10m BETWEEN 191.25 AND 213.75 THEN 'SSW'
            WHEN wind_direction_10m BETWEEN 213.75 AND 236.25 THEN 'SW'
            WHEN wind_direction_10m BETWEEN 236.25 AND 258.75 THEN 'WSW'
            WHEN wind_direction_10m BETWEEN 258.75 AND 281.25 THEN 'W'
            WHEN wind_direction_10m BETWEEN 281.25 AND 303.75 THEN 'WNW'
            WHEN wind_direction_10m BETWEEN 303.75 AND 326.25 THEN 'NW'
            WHEN wind_direction_10m BETWEEN 326.25 AND 348.75 THEN 'NNW'
        end as wind_cardinal_direction
    from `global-env-447720-j9.zoom_cap_bq.weather_data`
)
select * from transformed_weather