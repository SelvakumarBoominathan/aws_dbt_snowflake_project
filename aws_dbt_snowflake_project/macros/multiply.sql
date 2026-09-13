{% macro multiply(x,y,precision)%}
    CAST(round({{x}} * {{y}}, {{precision}}) AS FLOAT)

{% endmacro%}