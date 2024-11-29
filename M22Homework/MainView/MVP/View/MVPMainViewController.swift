import UIKit
import SnapKit

class MVPMainViewController: UIViewController, UISearchBarDelegate {
    private lazy var searchBar = UISearchBar()
    private lazy var tableView = UITableView()
    private let cellIdentifier = "MyCell"
    var presenter: MainViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellLabelAndImage.self, forCellReuseIdentifier: cellIdentifier)
        setupConstraints()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let nameFilmForSearch = searchBar.text ?? ""
        presenter.getFilms(nameFilmForSearch: nameFilmForSearch)
        searchBar.resignFirstResponder()
    }
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.right.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.topMargin).inset(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

extension MVPMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.films?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellLabelAndImage
        let viewModel = presenter.films
        cell?.label.text = viewModel?[indexPath.row].nameRu ?? ""
        cell?.imageViewCell.image = viewModel?[indexPath.row].posterUrlPreview ?? UIImage()
        return cell ?? UITableViewCell()
    }
}

extension MVPMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = presenter.films?[indexPath.row]
        lazy var descriptionViewController = DescriptionViewController()
        descriptionViewController.ruName = viewModel?.nameRu ?? ""
        descriptionViewController.duration = viewModel?.filmLength ?? ""
        descriptionViewController.enName = viewModel?.nameEn ?? ""
        descriptionViewController.ratingValue = viewModel?.rating ?? ""
        descriptionViewController.year = viewModel?.year ?? ""
        descriptionViewController.ruDescription = viewModel?.description ?? ""
        descriptionViewController.image = viewModel?.posterUrlPreview ?? UIImage()
        self.present(descriptionViewController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MVPMainViewController: MainViewProtocol {
    func succes() {
        tableView.reloadData()
    }
    func failure(error: any Error) {
        print("Error MVPMainViewController")
    }
}
