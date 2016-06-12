function my_Gale_Shap{T<:Int64}(m_prefs::AbstractArray{T, 2}, f_prefs::AbstractArray{T, 2})
    m = size(m_prefs, 2)
    n = size(f_prefs, 2)
    m_matched = zeros(Int64, m)
    f_matched = zeros(Int64, n)
    for t in 1:(n+1)
        for i in 1:m
            if m_matched[i] == 0
                if m_prefs[t, i] == 0
                    m_matched[i] = 0
                else
                    if f_matched[m_prefs[t, i]] == 0
                        f_matched[m_prefs[t, i]] = i
                        m_matched[i] = m_prefs[t, i]
                        elseif (f_matched[m_prefs[t, i]] != i) && (findnext(f_prefs[:, m_prefs[t, i]], f_matched[m_prefs[t, i]], 1) > findnext(f_prefs[:, m_prefs[t, i]], i, 1))
                        m_matched[f_matched[m_prefs[t, i]]] = 0
                        f_matched[m_prefs[t, i]] = i
                        m_matched[i] = m_prefs[t, i]
                    else
                        f_matched[m_prefs[t, i]] = f_matched[m_prefs[t, i]]
                        m_matched[i] = m_matched[i]
                    end
                end
            else
                m_matched[i] = m_matched[i]
            end
        end
    end
    return m_matched, f_matched
end