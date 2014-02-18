#!/bin/bash
{% for vers in keep_matlab_versions %}
/usr/local/MATLAB/{{ vers }}/bin/activate_matlab.sh
{% endfor %}
/usr/local/bin/mathematica
